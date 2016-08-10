#! /usr/bin/octave -q
% Copyright (C) 2016 Alberto Otero-de-la-Roza
%
% This octave routine is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or (at
% your option) any later version. See <http://www.gnu.org/licenses/>.
%
% The routine distributed in the hope that it will be useful, but WITHOUT
% ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
% FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
% more details.

## Script for the calculation of the elastic constant tensor, quantum
## espresso version. The Cij are determined by calculating the stress
## tensor under imposed strain, then doing a least-squares fit.
## 
## In this script,
## - e = (e1 ... e6) is the strain vector in Voigt notation.
## 
## - emat = [e1   e6/2 e5/2
##           e6/2 e2   e4/2
##           e5/2 e4/2 e3];
## is the strain tensor.
##
## If s = (s1 .. s6) is the stress vector in Voigt notation, then:
##   s = C * e
## where s and e are 6x1 column vectors and C is the elastic constant
## matrix. The compliance matrix is defined as S = inv(C), or:
##   e = S * s
## 
## These scripts work by using the ability of solid-state codes to
## calcualate the stress tensor for arbitrary strains. A number of
## strains e(i) with i = 1...n in the neighborhood of e = 0 can be
## chosen and the corresponding strains s(i) calculated using DFT
## methods. If we arrange these in nx6 super-matrices smat(i,:) and
## emat(i,:), then C can be determined (note e, C, and s are
## symmetric): 
##   s' = e' * C
##   C = pinv(emat) * smat
## where pinv is the pseudo-inverse of the strain tensor
## super-matrix. This procedures calculates the C that minimizes
## the deviation between all calcualted s(i) and C * e(i) in a
## least-squares sense. 
##
## The choice of strains is more or less arbitrary, but there should
## be enough strains to determine all components in the elastic tensor
## matrix. In general, strains along six directions with e(i) != 0 and
## zero for all the other components should be enough. In
## high-symmetry cases, fewer strains are necessary. For now, only
## cubic crystals are implemented. 
##
## The magnitude of the strain should be chosen carefully. It should
## be high enough that numerically significant stress tensors are
## produced from the first principles calculation, but it should not
## be so high that the linear relations between s and e are no longer
## valid. The actual value depends on the crystal under study.

## The following items should be in the same directory:
##
## 1. The QE input (bleh.scf.in) for the equilibrium geometry. It should 
## have: 
##   tstress=.true., (in &control)
##   calculation='relax',
##   &ions /
## 2. The pseudopotentials necessary to run the calculation.
##
## In addition, the CELL_PARAMETERS at equilibrium should be copied in the r_eq
## block below.

## cij determined by strain-stress relations, least squares fit.
base = "mgo";

## the calculated equilibrium R (rows are lattice vectors in au)
r_eq = [
   3.962531347  -3.962531347  -0.000000000
  -3.962531347   0.000000000   3.962531347
   0.000000000  -3.962531347  -3.962531347
]; 

## The finite deformations (tweak until the energy differences are reasonable). 
erange = [-0.050 -0.025 0.025 0.05];

## Symmetry type (only cubic and general are supported for now).
## symtype = "cubic";
symtype = "general";

### end of the input block ###

if (strcmp(symtype,"cubic"))
  ## cubic
  jmax = 2;
  jvec = [
          1 0 0 0 0 0
          0 0 0 1 1 1
  ];
else
  ## general
  jmax = 6;
  jvec = eye(6);
endif

# 
for i = 1:length(erange)
  for j = 1:jmax
    s = sprintf("%s_%d_%d",base,i,j);
    system(sprintf("mkdir %s",s));
    system(sprintf("cp -f *.UPF %s",s));

    # define the strain vector in Voigt notation
    e = jvec(j,:) * erange(i);
    
    # Pack the 6-vector in the strain matrix
    emat = zeros(3,3);
    for k = 1:3
      emat(k,k) = 1 + e(k);
    endfor
    emat(2,3) = emat(3,2) = e(4)/2;
    emat(1,3) = emat(3,1) = e(5)/2;
    emat(1,2) = emat(2,1) = e(6)/2;

    # Obtain the deformed lattice vectors
    r = r_eq * emat;

    # Write the input file (QE)
    file = sprintf("%s/%s.scf.in",s,s);
    system(sprintf("awk 'FNR==1,/CELL_PARAMETERS/' %s.scf.in > %s",base,file));
    fid = fopen(file,"a");
    for k = 1:3
      fprintf(fid,"%.10f %.10f %.10f\n",r(k,:));
    endfor
    fclose(fid);
    system(sprintf("awk '/CELL_PARAMETERS/,!/./' %s.scf.in | tail -n +5 >> %s",base,file));
  endfor
endfor


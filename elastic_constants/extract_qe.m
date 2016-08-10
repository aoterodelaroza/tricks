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

## Cij determined using strain-stress relations and a least squares
## fit. See the generator script for details.

## The input block should be the same as in gen.m

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

tmat = smat = zeros(length(erange)*jmax,6);
n = 0;
for i = 1:length(erange)
  for j = 1:jmax

    n += 1;
    s = sprintf("%s_%d_%d",base,i,j);

    ## define the strain vector in Voigt notation
    e = jvec(j,:) * erange(i);
    
    ## pack the 6-vector in the strain matrix
    emat = zeros(3,3);
    for k = 1:3
      emat(k,k) = 1 + e(k);
    endfor
    emat(2,3) = emat(3,2) = e(4)/2;
    emat(1,3) = emat(3,1) = e(5)/2;
    emat(1,2) = emat(2,1) = e(6)/2;

    ## get the stress tensor
    [s,out] = system(sprintf("grep -A 3 'total   stress' %s/%s.scf.out | tail -n 3 | awk '{print $4, $5, $6}'",s,s));
    aux = -str2num(out) / 10;
    t = [aux(1,1), aux(2,2), aux(3,3), aux(2,3), aux(1,3), aux(1,2)];

    ## accumulate in the super-matrix
    tmat(n,:) = t;
    smat(n,:) = e;
  endfor
endfor

## elastic constant tensor
cij = pinv(smat) * tmat;
sij = inv(cij);

if (strcmp(symtype,"cubic"))
  cij(2,2) = cij(3,3) = cij(1,1);
  cij(2,1) = cij(3,1) = cij(3,2) = cij(2,3) = cij(1,2) = cij(1,3);
  cij(4,4) = cij(5,5) = cij(6,6) = sum(cij(4,4:6));
  cij(4,5) = cij(4,6) = cij(5,6) = cij(5,4) = cij(6,4) = cij(6,5) = 0;
  cij(1:3,4:6) = cij(4:6,1:3) = 0;
  printf("C11 (GPa) = %.2f\n",cij(1,1));
  printf("C12 (GPa) = %.2f\n",cij(1,2));
  printf("C44 (GPa) = %.2f\n",cij(4,4));
else
  printf("# Elastic constant matrix (Cij, GPa):\n")
  for i = 1:6
    for j = 1:6
      printf("%8.3f ",cij(i,j));
    endfor
    printf("\n");
  endfor
  printf("\n");

  printf("# Compliance matrix (Sij, GPa^-1):\n")
  for i = 1:6
    for j = 1:6
      printf("%12.3e ",sij(i,j));
    endfor
    printf("\n");
  endfor
  printf("\n");
endif
printf("Eigenvalues: %.2f %.2f %.2f %.2f %.2f %.2f\n",eig(cij));


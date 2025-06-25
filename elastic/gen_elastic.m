#! /usr/bin/octave -q
% Copyright (C) 2016-2020 Alberto Otero-de-la-Roza
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

### Input variables
forcetriclinic=0; ## if 1, force triclinic symmetry
erange = linspace(-0.003,0.003,8); ## the range for the deformations
symeps=1e-1; ## symmetry epsilon for space group detection
interface="fhi"; ## {vasp|qe|fhi} - which program are we working with?
###################

## Scripts for the calculation of the elastic constant tensor. The Cij
## are determined by calculating the stress tensor under imposed
## strain, then doing a linear least-squares fit.  This is the
## generator script. A companion script is provided for extracting the
## stresses and calculating the elastic constants.

## QE: the following items should be in the same directory (called
## bleh/) as the script:
##
## 1. The QE input (bleh.scf.in) for the equilibrium geometry. It should
## have:
##   &control
##     tstress=.true.,
##     pseudo='..',
##     calculation='relax',
##   /
##   &system
##     ibrav=0,
##   /
##   &ions
##   /
## and CELL_PARAMETERS in bohr.
##
## VASP: the POSCAR for the equilibrium geometry should be in the same
## directory as the script. To run the deformations, use IBRION=2 and
## ISIF=2 to relax the atomic positions at fixed cell volume and
## shape.
##
## FHIaims: the control.in and geometry.in for the equilibrium
## geometry should be in the same directory as the script. The atomic
## positions in the geometry.in must be given as atom_frac. The
## control.in must have:
##   relax_unit_cell none
##   compute_analytical_stress .true.
##

## cij determined by strain-stress relations, least squares fit.
[s out] = system("basename $(pwd)");
base = strrep(out,"\n","");
printf("Base name: %s\n",base);

## check scf.in exists
if (strcmp(interface,"qe"))
  if (!exist(sprintf("%s.scf.in",base),"file"))
    error(sprintf("file %s.scf.in does not exist",base))
  endif
  bfile = sprintf("%s.scf.in",base);
elseif (strcmp(interface,"vasp"))
  if (!exist(sprintf("POSCAR"),"file"))
    error("file POSCAR does not exist")
  endif
  bfile = "POSCAR";
elseif (strcmp(interface,"fhi"))
  if (!exist(sprintf("geometry.in"),"file"))
    error("file geometry.in does not exist")
  endif
  bfile = "geometry.in";
else
  error("unknown interface")
end

## Symmetry type
[s out] = system(sprintf("echo 'sym %.2e \n crystal %s' | critic2  | awk '/^ *Laue class/{print $NF}'",symeps,bfile));
laue = strtrim(out);
if (isempty(laue))
  error("Error trying to find the symmetry type")
elseif (strcmp(laue,"m-3") || strcmp(laue,"m-3m"))
  symtype = "cubic";
elseif (strcmp(laue,"6/m") || strcmp(laue,"6/mmm"))
  symtype = "hexagonal";
elseif (strcmp(laue,"4/m"))
  symtype = "tetragonal1";
elseif (strcmp(laue,"4/mmm"))
  symtype = "tetragonal2";
elseif (strcmp(laue,"-3"))
  symtype = "trigonal1";
elseif (strcmp(laue,"-3m"))
  symtype = "trigonal2";
elseif (strcmp(laue,"mmm"))
  symtype = "orthorhombic";
elseif (strcmp(laue,"2/m"))
  symtype = "monoclinic";
else ## -1 and unknown
  symtype = "triclinic";
endif
if (forcetriclinic == 1)
  symtype = "triclinic";
endif
printf("Laue class: %s\n",laue);
printf("Symmetry type: %s\n",symtype);

## The calculated equilibrium R (rows are lattice vectors in au)
if (strcmp(interface,"vasp"))
  [s out] = system(sprintf("awk 'FNR>=3 && FNR<=5' %s",bfile));
  r_eq = str2num(out) / 0.52917720859;
elseif (strcmp(interface,"qe"))
  [s out] = system(sprintf("grep -A 3 CELL %s | tail -n 3",bfile));
  r_eq = str2num(out);
elseif (strcmp(interface,"fhi"))
  [s out] = system(sprintf("grep 'lattice_vector' %s | awk '{print $2,$3,$4}'",bfile));
  r_eq = str2num(out) / 0.52917720859;
endif
printf("Reference lattice vectors (bohr):\n");
printf("  a: %14.8f %14.8f %14.8f\n",r_eq(1,:));
printf("  b: %14.8f %14.8f %14.8f\n",r_eq(2,:));
printf("  c: %14.8f %14.8f %14.8f\n",r_eq(3,:));
printf("Reference lattice vectors (ang):\n");
printf("  a: %14.8f %14.8f %14.8f\n",r_eq(1,:)*0.52917720859);
printf("  b: %14.8f %14.8f %14.8f\n",r_eq(2,:)*0.52917720859);
printf("  c: %14.8f %14.8f %14.8f\n",r_eq(3,:)*0.52917720859);

## Define strains
## R. Golesorkhtabar et al., Comput. Phys. Commun., 184 (2013), 1861. (https://doi.org/10.1016/j.cpc.2013.03.010)
## Yu et al., Comput. Phys. Commun. 181 (2010) 671. (https://doi.org/10.1016/j.cpc.2009.11.017)
if (strcmp(symtype,"cubic"))
  jvec = [
           1  2  3  4  5  6
  ];
elseif (strcmp(symtype,"hexagonal") || strcmp(symtype,"trigonal1") ||...
        strcmp(symtype,"trigonal2") || strcmp(symtype,"tetragonal1") ||...
        strcmp(symtype,"tetragonal2"))
  jvec = [
           1  2  3  4  5  6
           3 -5 -1  6  2 -4
  ];
elseif (strcmp(symtype,"orthorhombic"))
  jvec = [
           1  2  3  4  5  6
           3 -5 -1  6  2 -4
           5  4  6 -2 -1 -3
  ];
elseif (strcmp(symtype,"monoclinic"))
  jvec = [
           1  2  3  4  5  6
          -2  1  4 -3  6 -5
           3 -5 -1  6  2 -4
          -4 -6  5  1 -3  2
           5  4  6 -2 -1 -3
  ];
else
  jvec = [
           1  2  3  4  5  6
          -2  1  4 -3  6 -5
           3 -5 -1  6  2 -4
          -4 -6  5  1 -3  2
           5  4  6 -2 -1 -3
          -6  3 -2  5 -4  1
  ];
endif
jmax = rows(jvec);

## Some output about the strains
printf("Applied strains (%d):\n",jmax)
for i = 1:jmax
  printf(" %d %d %d %d %d %d\n",jvec(i,:));
endfor
printf("Strain extent (%d): ",length(erange));
for i = 1:length(erange)
  printf("%.3e ",erange(i));
endfor
printf("\n\n");

## Create the strains and output the list
printf("|   Strain    |   Extent     |    Name    |\n");
for j = 1:jmax
  for i = 1:length(erange)
    s = sprintf("%s_%d_%d",base,i,j);
    system(sprintf("mkdir %s",s));

    # define the infinitesimal strain vector in Voigt notation
    e = jvec(j,:) * erange(i);

    # Pack the 6-vector in the infinitesimal strain matrix
    emat = zeros(3,3);
    for k = 1:3
      emat(k,k) = e(k);
    endfor
    emat(2,3) = emat(3,2) = e(4)/2;
    emat(1,3) = emat(3,1) = e(5)/2;
    emat(1,2) = emat(2,1) = e(6)/2;

    # Obtain the deformed lattice vectors
    r = r_eq * (eye(3) + emat);

    # Write the input file (QE)
    if (strcmp(interface,"qe"))
      file = sprintf("%s/%s.scf.in",s,s);
      system(sprintf("awk 'FNR==1,/CELL_PARAMETERS/' %s.scf.in > %s",base,file));
      fid = fopen(file,"a");
      for k = 1:3
        fprintf(fid,"%.10f %.10f %.10f\n",r(k,:));
      endfor
      fclose(fid);
      system(sprintf("awk '/CELL_PARAMETERS/,!/./' %s.scf.in | tail -n +5 >> %s",base,file));
    elseif (strcmp(interface,"vasp"))
      file = sprintf("%s/POSCAR",s);
      system(sprintf("awk 'FNR==1,FNR==2' %s > %s",bfile,file));
      fid = fopen(file,"a");
      for k = 1:3
        fprintf(fid,"%.10f %.10f %.10f\n",r(k,:) * 0.52917720859);
      endfor
      fclose(fid);
      system(sprintf("awk 'FNR>=6' %s >> %s",bfile,file));
    elseif (strcmp(interface,"fhi"))
      file = sprintf("%s/geometry.in",s);
      fid = fopen(file,"a");
      for k = 1:3
        fprintf(fid,"lattice_vector %.10f %.10f %.10f\n",r(k,:) * 0.52917720859);
      endfor
      fclose(fid);
      system(sprintf("awk '/^atom_frac/' %s >> %s",bfile,file));
    endif

    printf("| %d %d %d %d %d %d | %12.3e | %s |\n",jvec(j,:),erange(i),s);
  endfor
endfor
printf("\n");

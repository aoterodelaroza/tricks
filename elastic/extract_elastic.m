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

### Input variables
forcetriclinic=0; ## if 1, force triclinic symmetry
erange = linspace(-0.003,0.003,8); ## the range for the deformations
ndeg=2; ## order of the fitting polynomial
symeps=1e-1; ## symmetry epsilon for space group detection
interface="fhi"; ## {vasp|qe|fhi} - which program are we working with?
###################

## Scripts for the calculation of the elastic constant tensor.  The
## Cij are determined by calculating the stress tensor under imposed
## strain, then doing a linear least-squares fit.  This is the
## extraction script. A companion script is provided for generating
## the input files.

## constants
kb = 1.3806488e-23; ## J/K
h = 6.62606957e-34; ## J.s
NA = 6.02214129e23; ## mol^{-1}

## function for maknig the tau vs. e gnuplot file
function makegnu_tau_e(file,base,j,istau)
  fid = fopen(file,"w");
  if (istau)
    fprintf(fid,"set terminal cairolatex standalone size 19cm,19cm header \\\n");
  else
    fprintf(fid,"set terminal cairolatex standalone header \\\n");
  endif
  fprintf(fid," \"\\\\usepackage[T1]{fontenc}\\n\\\\usepackage{mathptmx}\\n\\\\usepackage{helvet}\" font \",14\"\n");
  fprintf(fid,"set encoding iso_8859_1\n");
  fprintf(fid,"\n");
  if (istau)
    fprintf(fid,"set output 'tau_e_%s_%d.tex'\n",base,j);
    fprintf(fid,"set multiplot layout 3, 2 \n");
  else
    fprintf(fid,"set output 'ene_e_%s_%d.tex'\n",base,j);
  endif
  fprintf(fid,"\n");
  fprintf(fid,"set style line 1   pt 7  lc rgb \"#000000\"\n");
  fprintf(fid,"set style line 2   pt 3  lc rgb \"#0000FF\"\n");
  fprintf(fid,"set style line 3   pt 5  lc rgb \"#FF0000\"\n");
  fprintf(fid,"set style line 4   pt 6  lc rgb \"#000000\"\n");
  fprintf(fid,"set style line 5   pt 2  lc rgb \"#0000FF\"\n");
  fprintf(fid,"\n");
  fprintf(fid,"set key top center\n");
  fprintf(fid,"set grid\n");
  fprintf(fid,"\n");
  fprintf(fid,"set xlabel 'Strain ($e\\times 10^{2}$)'\n");
  if (istau)
    fprintf(fid,"set ylabel '$\\tau$ (GPa)'\n");
  else
    fprintf(fid,"set ylabel '$E$ (Ry)'\n");
    fprintf(fid,"set format y \"%%.4f\"\n");
  endif
  fprintf(fid,"\n");

  if (istau)
    fprintf(fid,"plot 'tau_e_%s_%d.dat' u ($1*100):2 w linespoints ls 1 title '$\\tau_1$ (calc)',\\\n",base,j);
    fprintf(fid,"     'tau_e_%s_%d.dat' u ($1*100):8 w points ls 2 title '$\\tau_1$ (obs)',\\\n",base,j);
    fprintf(fid,"\n");
    fprintf(fid,"plot 'tau_e_%s_%d.dat' u ($1*100):3 w linespoints ls 1 title '$\\tau_2$ (calc)',\\\n",base,j);
    fprintf(fid,"     'tau_e_%s_%d.dat' u ($1*100):9 w points ls 2 title '$\\tau_2$ (obs)',\\\n",base,j);
    fprintf(fid,"\n");
    fprintf(fid,"plot 'tau_e_%s_%d.dat' u ($1*100):4  w linespoints ls 1 title '$\\tau_3$ (calc)',\\\n",base,j);
    fprintf(fid,"     'tau_e_%s_%d.dat' u ($1*100):10 w points ls 2 title '$\\tau_3$ (obs)',\\\n",base,j);
    fprintf(fid,"\n");
    fprintf(fid,"plot 'tau_e_%s_%d.dat' u ($1*100):5  w linespoints ls 1 title '$\\tau_4$ (calc)',\\\n",base,j);
    fprintf(fid,"     'tau_e_%s_%d.dat' u ($1*100):11 w points ls 2 title '$\\tau_4$ (obs)',\\\n",base,j);
    fprintf(fid,"\n");
    fprintf(fid,"plot 'tau_e_%s_%d.dat' u ($1*100):6  w linespoints ls 1 title '$\\tau_5$ (calc)',\\\n",base,j);
    fprintf(fid,"     'tau_e_%s_%d.dat' u ($1*100):12 w points ls 2 title '$\\tau_5$ (obs)',\\\n",base,j);
    fprintf(fid,"\n");
    fprintf(fid,"plot 'tau_e_%s_%d.dat' u ($1*100):7  w linespoints ls 1 title '$\\tau_6$ (calc)',\\\n",base,j);
    fprintf(fid,"     'tau_e_%s_%d.dat' u ($1*100):13 w points ls 2 title '$\\tau_6$ (obs)',\\\n",base,j);
  else
    fprintf(fid,"plot 'ene_e_%s_%d.dat' u ($1*100):2  w linespoints ls 3 title '$E$ (obs)',\\\n",base,j);
    fprintf(fid,"     'ene_e_%s_%d.dat' u ($1*100):3  w linespoints ls 4 title '$E$ (calc,$\\epsilon$)',\\\n",base,j);
    fprintf(fid,"     'ene_e_%s_%d.dat' u ($1*100):4  w linespoints ls 5 title '$E$ (calc,$\\eta$)',\\\n",base,j);
  endif
  fclose(fid);
endfunction

## cij determined by strain-stress relations, least squares fit.
printf("## Crystal details\n");
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

## Check if scf.out exists
if (exist(sprintf("%s.scf.out",base),"file") && strcmp(interface,"qe"))
  doene = 1;
else
  doene = 0;
endif

## gather information using critic2
[s out] = system(sprintf("echo 'sym %.2e \n crystal %s' | critic2  | awk '/Laue class/ || /Number of atoms in the unit cell/ || /Density/ || /Molar mass/{print $NF}'",symeps,bfile));
[nat, molmass, rho, laue] = sscanf(out,"%d %f %f %s","C");
printf("Number of atoms: %d\n",nat);
printf("Molar mass (amu): %.5f\n",molmass);
printf("Density (g/cm^3): %.3f\n",rho);
printf("Laue class: %s\n",laue);

## Symmetry type
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

## volume
omega = det(r_eq);
printf("Volume (bohr^3) = %.5f\n",omega);
printf("Volume (ang^3) = %.5f\n",omega*0.529177^3);

## Define the strains
## R. Golesorkhtabar et al., Comput. Phys. Commun., 184 (2013), 1861. (https://doi.org/10.1016/j.cpc.2013.03.010)
## Yu et al., Comput. Phys. Commun. 181 (2010) 671. (https://doi.org/10.1016/j.cpc.2009.11.017)
if (strcmp(symtype,"cubic"))
  jvec = [
           1  2  3  4  5  6
  ];
  cpat = [
           # 1=c11 2=c12 3=c44
          1 2 2 0 0 0
          2 1 2 0 0 0
          2 2 1 0 0 0
          0 0 0 3 0 0
          0 0 0 0 3 0
          0 0 0 0 0 3
  ];
elseif (strcmp(symtype,"hexagonal"))
  jvec = [
           1  2  3  4  5  6
           3 -5 -1  6  2 -4
  ];
  cpat = [
          # 1=c11 2=c12 3=c13 4=c33 5=c44
          1 2 3  0 0 0
          2 1 3  0 0 0
          3 3 4  0 0 0
          0 0 0  5 0 0
          0 0 0  0 5 0
          0 0 0  0 0 10102
  ];
elseif (strcmp(symtype,"tetragonal2"))
  jvec = [
           1  2  3  4  5  6
           3 -5 -1  6  2 -4
  ];
  cpat = [
          # 1=c11 2=c12 3=c13 4=c33 5=c44 6=c66
          1 2 3  0 0 0
          2 1 3  0 0 0
          3 3 4  0 0 0
          0 0 0  5 0 0
          0 0 0  0 5 0
          0 0 0  0 0 6
  ];
elseif (strcmp(symtype,"tetragonal1"))
  jvec = [
           1  2  3  4  5  6
           3 -5 -1  6  2 -4
  ];
  cpat = [
          # 1=c11 2=c12 3=c13 4=c16 5=c33 6=c44 7=c66
          1  2 3  0 0  4
          2  1 3  0 0 -4
          3  3 5  0 0  0
          0  0 0  6 0  0
          0  0 0  0 6  0
          4 -4 0  0 0  7
  ];
elseif (strcmp(symtype,"trigonal2"))
  jvec = [
           1  2  3  4  5  6
           3 -5 -1  6  2 -4
  ];
  cpat = [
          # 1=c11 2=c12 3=c13 4=c14 5=c33 6=c44
          1  2 3  4 0 0
          2  1 3 -4 0 0
          3  3 5  0 0 0
          4 -4 0  6 0 0
          0  0 0  0 6 4
          0  0 0  0 4 10102
  ];
elseif (strcmp(symtype,"trigonal1"))
  jvec = [
           1  2  3  4  5  6
           3 -5 -1  6  2 -4
  ];
  cpat = [
          # 1=c11 2=c12 3=c13 4=c14 5=c25 6=c33 7=c44
          1  2 3  4 -5 0
          2  1 3 -4  5 0
          3  3 6  0  0 0
          4 -4 0  7  0 5
         -5  5 0  0  7 4
          0  0 0  5  4 10102
  ];
elseif (strcmp(symtype,"orthorhombic"))
  jvec = [
           1  2  3  4  5  6
           3 -5 -1  6  2 -4
           5  4  6 -2 -1 -3
  ];
  cpat = [ # 1=c11 2=c12 3=c13 4=c22 5=c23 6=c33 7=c44 8=c55 9=c66
           1 2 3 0 0 0
           2 4 5 0 0 0
           3 5 6 0 0 0
           0 0 0 7 0 0
           0 0 0 0 8 0
           0 0 0 0 0 9
  ];
elseif (strcmp(symtype,"monoclinic"))
  jvec = [
           1  2  3  4  5  6
          -2  1  4 -3  6 -5
           3 -5 -1  6  2 -4
          -4 -6  5  1 -3  2
           5  4  6 -2 -1 -3
  ];
  cpat = [ # 1=c11 2=c12 3=c13 4=c15 5=c22 6=c23 7=c25 8=c33 9=c35 10=c44 11=c46 12=c55 13=c66
           1  2  3  0  4  0
           2  5  6  0  7  0
           3  6  8  0  9  0
           0  0  0 10  0 11
           4  7  9  0 12  0
           0  0  0 11  0 13
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
  cpat = [ # 1=c11 2=c12 3=c13 4=c14 5=c15 6=c16 7=c22 8=c23 9=c24 10=c25 11=c26 12=c33 13=c34 14=c35 15=c36 16=c44 17=c45 18=c46 19=c55 20=c56 21=c66
           1  2  3  4  5  6
           2  7  8  9 10 11
           3  8 12 13 14 15
           4  9 13 16 17 18
           5 10 14 17 19 20
           6 11 15 18 20 21
  ];
endif
jmax = rows(jvec);

## Build the jcoef matrix from the cij pattern (cpat) and the strain patterns (jvec)
cmax = max(max(abs(cpat(find(cpat < 100)))));
jcoef = zeros(rows(jvec)*6,cmax);
 n = 0;
for j = 1:rows(jvec)
  for k = 1:6
    n++;
    for l = 1:6
      if (cpat(k,l) > 100)
        c2 = mod(cpat(k,l),100);
        c1 = (cpat(k,l)-c2)/100;
        c1 = mod(c1,100);
        jcoef(n,c1) += jvec(j,l)/2;
        jcoef(n,c2) -= jvec(j,l)/2;
      elseif (cpat(k,l) > 0)
        jcoef(n,cpat(k,l)) += jvec(j,l);
      elseif (cpat(k,l) < 0)
        jcoef(n,-cpat(k,l)) -= jvec(j,l);
      endif
    endfor
  endfor
endfor

## Some output about the strains
printf("Symmetry pattern:\n");
for i = 1:6
  for j = 1:6
    printf("%2d ",cpat(i,j));
  endfor
  printf("\n");
endfor

printf("Applied strains (%d):\n",jmax)
for i = 1:jmax
  printf(" %d %d %d %d %d %d\n",jvec(i,:));
endfor
printf("Strain extent (%d): ",length(erange));
for i = 1:length(erange)
  printf("%.3e ",erange(i));
endfor
printf("\n\n");

## Read the zero-strain energy, stress, and pressure
if (doene && strcmp(interface,"qe"))
  ene0 = 0;
  [s,out] = system(sprintf("grep ! %s.scf.out | tail -n 1 | awk '{print $5}'",base));
  if (!isempty(out))
    ene0 = str2num(out);
  endif
  ene = zeros(length(erange),jmax);

  [s,out] = system(sprintf("grep -A 3 'total   stress' %s.scf.out | tail -n 3 | awk '{print $1, $2, $3}'",base));
  if (isempty(out))
    error(sprintf("stress not found in file: %s\n",file));
  endif
  tau0 = -str2num(out) * 147105.08 / 10; ## to GPa; to thermodynamic sign convention
  p = -trace(tau0)/3;
endif

tmat = smat = zeros(6,length(erange),jmax);
for j = 1:jmax
  for i = 1:length(erange)
    str = sprintf("%s_%d_%d",base,i,j);

    ## define the infinitesimal strain vector in Voigt notation
    e = jvec(j,:) * erange(i);

    ## get the stress tensor from the output
    if (strcmp(interface,"qe"))
      file = sprintf("%s/%s.scf.out",str,str);
      if (!exist(file))
        error(sprintf("file not found: %s\n",file));
      endif
      [s,out] = system(sprintf("grep -A 3 'total   stress' %s/%s.scf.out | tail -n 3 | awk '{print $1, $2, $3}'",str,str));
      if (isempty(out))
        error(sprintf("stress not found in file: %s\n",file));
      endif
      aux = -str2num(out) * 147105.08 / 10; ## to GPa; to thermodynamic sign convention
      t = [aux(1,1), aux(2,2), aux(3,3), aux(2,3), aux(1,3), aux(1,2)]; ## to Voigt
    elseif (strcmp(interface,"vasp"))
      file = sprintf("%s/OUTCAR",str);
      if (!exist(file))
        error(sprintf("file not found: %s\n",file));
      endif
      [s out] = system(sprintf("grep -B 1 Pullay %s/OUTCAR  | grep 'in kB'  | tail -n 1  | awk '{print $3,$4,$5,$6,$7,$8}'",str));
      if (isempty(out))
        error(sprintf("stress not found in file: %s\n",file));
      endif
      aux = -str2num(out) / 10; ## to GPa; to thermodynamic sign convention
      t = [aux(1), aux(2), aux(3), aux(5), aux(6), aux(4)]; ## to Voigt
    elseif (strcmp(interface,"fhi"))
      file = sprintf("%s/%s.out",str,str);
      if (!exist(file))
        error(sprintf("file not found: %s\n",file));
      endif
      [s out] = system(sprintf("grep -A 7 'Analytical stress tensor - Symmetrized' %s | tail -n 3 | awk '{print $3,$4,$5}'",file));
      if (isempty(out))
        error(sprintf("stress not found in file: %s\n",file));
      endif
      aux = str2num(out) * 160.21766; ## to GPa
      t = [aux(1,1), aux(2,2), aux(3,3), aux(2,3), aux(1,3), aux(1,2)]; ## to Voigt
    endif

    ## read the energies
    if (doene && strcmp(interface,"qe"))
      [s,out] = system(sprintf("grep ! %s/%s.scf.out | tail -n 1 | awk '{print $5}'",str,str));
      if (!isempty(out))
        ene(i,j) = str2num(out);
      endif
    endif

    ## accumulate in the super-matrix
    tmat(:,i,j) = t';
    smat(:,i,j) = e';
  endfor
endfor

## elastic constant tensor
cij = zeros(6);

## gather information and calculate the slopes
tslope = zeros(6*jmax,1);
cres = zeros(6,jmax);
n = 0;
for j = 1:jmax
  ## calculate the slopes for the strain patterns and stress components
  for k = 1:6
    cc = polyfit(erange,tmat(k,:,j),ndeg);
    ccp = polyder(cc);
    n++;
    tslope(n) = polyval(ccp,0);
    cres(k,j) = polyval(cc,0);
  endfor
endfor

## calculate the elastic coefficients and build the cij matrix
c = pinv(jcoef) * tslope;
for i = 1:6
  for j = i:6
    if (cpat(i,j) > 100)
      c2 = mod(cpat(i,j),100);
      c1 = (cpat(i,j)-c2)/100;
      c1 = mod(c1,100);
      cij(i,j) = cij(j,i) = (c(c1) - c(c2))/2;
    elseif (cpat(i,j) < 0)
      cij(i,j) = cij(j,i) = -c(-cpat(i,j));
    elseif (cpat(i,j) > 0)
      cij(i,j) = cij(j,i) = c(cpat(i,j));
    endif
  endfor
endfor

## symmetrize the cij matrix
cij = 0.5 * (cij + cij');

## Make the analysis plots, stress
dirname = sprintf("%s_fits",base);
printf("## Writing plots to: %s/\n",dirname);
if (exist(dirname,"dir"))
  system(sprintf("rm -r %s/*",dirname));
else
  system(sprintf("mkdir %s",dirname));
endif
for j = 1:jmax
  fildat = sprintf("%s/tau_e_%s_%d.dat",dirname,base,j);
  filgnu = sprintf("%s/tau_e_%s_%d.gnu",dirname,base,j);
  fid = fopen(fildat,"w");
  fprintf(fid,"#     e         tau_1(calc)  tau_2(calc)    tau_3(calc)  tau_4(calc)    tau_5(calc)  tau_6(calc)    tau_1(obs)   tau_2(obs)     tau_3(obs)   tau_4(obs)     tau_5(obs)   tau_6(obs)\n");
  for i = 1:length(erange)
    s = sprintf("%s_%d_%d",base,i,j);

    tobs = tmat(1:6,i,j) - cres(:,j);
    tcalc = cij * smat(1:6,i,j);
    fprintf(fid,"%12.6e %12.6e %12.6e %12.6e %12.6e %12.6e %12.6e %12.6e %12.6e %12.6e %12.6e %12.6e %12.6e\n",...
            erange(i),tcalc,tobs);
  endfor
  fclose(fid);

  makegnu_tau_e(filgnu,base,j,1);
  printf("# Plot: %s and %s\n",fildat,filgnu);
endfor

## Make the analysis plots, energy
if (doene)
  ## Cij elastic constant matrix, infinitesimal strain
  ## Bijkl = Cijkl(inf) + p/2 * (2*dij*dkl - dil*djk - djl*dik)
  cij_inf = cij - p * [
                       0.000 1.000 1.000 0.000 0.000 0.000
                       1.000 0.000 1.000 0.000 0.000 0.000
                       1.000 1.000 0.000 0.000 0.000 0.000
                       0.000 0.000 0.000 -0.500 0.000 0.000
                       0.000 0.000 0.000 0.000 -0.500 0.000
                       0.000 0.000 0.000 0.000 0.000 -0.500
                  ];
  ## Cij elastic constant matrix, finite strain
  ## Bijkl = Cijkl(eta) + p * (dij*dkl - djl*dik - dil*djk)
  cij_eta = cij - p * [
                       -1.000 1.000 1.000 0.000 0.000 0.000
                        1.000 -1.000 1.000 0.000 0.000 0.000
                        1.000 1.000 -1.000 0.000 0.000 0.000
                        0.000 0.000 0.000 -1.000 0.000 0.000
                        0.000 0.000 0.000 0.000 -1.000 0.000
                        0.000 0.000 0.000 0.000 0.000 -1.000
                  ];

  for j = 1:jmax
    fildat = sprintf("%s/ene_e_%s_%d.dat",dirname,base,j);
    filgnu = sprintf("%s/ene_e_%s_%d.gnu",dirname,base,j);
    fid = fopen(fildat,"w");

    fprintf(fid,"#     e          ene(obs)     ene(calc,inf)  ene(calc,eta)\n");
    for i = 1:length(erange)
      ## infinitesimal strain, Voigt notation
      e = jvec(j,:) * erange(i);

      ## infinitesimal strain, matrix notation
      emat = zeros(3,3);
      for k = 1:3
        emat(k,k) = 1 + e(k);
      endfor
      emat(2,3) = emat(3,2) = e(4)/2;
      emat(1,3) = emat(3,1) = e(5)/2;
      emat(1,2) = emat(2,1) = e(6)/2;

      ## finite strain, matrix notation
      etamat = 0.5 * (emat' * emat - eye(3));

      ## finite strain, Voigt notation
      eta = [etamat(1,1), etamat(2,2), etamat(3,3), 2*etamat(2,3), 2*etamat(1,3), 2*etamat(1,2)];

      ## Predicted energies, using the infinitesimal and finite Cij matrices (1 GPa * bohr^3 = 6.7978618e-05 Ry)
      ecalc1 = ene0 + (  e*tmat(1:6,i,j) - 0.5 *   e * cij_inf *   e') * omega * 6.7978618e-05;
      ecalc2 = ene0 + (eta*tmat(1:6,i,j) - 0.5 * eta * cij_eta * eta') * omega * 6.7978618e-05;

      fprintf(fid,"%.10f %.10f %.10f %.10f\n",erange(i),ene(i,j),ecalc1,ecalc2);
    endfor
    fclose(fid);

    makegnu_tau_e(filgnu,base,j,0);
    printf("# Plot: %s and %s\n",fildat,filgnu);
  endfor
endif
printf("\n");

## Output elastic properties
printf("## Elastic constant tensor (Bij, GPa):\n")
for i = 1:6
  for j = 1:6
    printf("%8.3f ",cij(i,j));
  endfor
  printf("\n");
endfor
printf("\n");

printf("Eigenvalues of Bij: %.2f %.2f %.2f %.2f %.2f %.2f\n",eig(cij));
printf("\n");

sij = inv(cij);
printf("## Elastic compliance tensor (Sij, GPa^{-1}):\n")
for i = 1:6
  for j = 1:6
    printf("%10.5f ",sij(i,j));
  endfor
  printf("\n");
endfor
printf("\n");

## Bulk modulus and polycrystalline averages
Bv = 1/9 * ((cij(1,1) + cij(2,2) + cij(3,3)) + 2 * (cij(1,2) + cij(1,3) + cij(2,3)));
Gv = 1/15 * ((cij(1,1) + cij(2,2) + cij(3,3)) - (cij(1,2) + cij(1,3) + cij(2,3)) + 3 * (cij(4,4) + cij(5,5) + cij(6,6)));
Br = 1/((sij(1,1) + sij(2,2) + sij(3,3)) + 2 * (sij(1,2) + sij(1,3) + sij(2,3)));
Gr = 15/(4*(sij(1,1) + sij(2,2) + sij(3,3)) - 4 * (sij(1,2) + sij(1,3) + sij(2,3)) + 3 * (sij(4,4) + sij(5,5) + sij(6,6)));
Bh = 0.5 * (Bv + Br);
Gh = 0.5 * (Gv + Gr);

printf("Bulk modulus (GPa) = %.2f\n",Br);
printf("Compressibility (GPa^{-1}) = %.5f\n",1/Br);
printf("\n");

printf("## Polycrystal averages\n");
printf("Voigt bulk modulus (BV, GPa) = %.2f\n",Bv);
printf("Reuss bulk modulus (BR, GPa) = %.2f\n",Br);
printf("Hill bulk modulus (BH, GPa) = %.2f\n",Bh);
printf("\n")

printf("Voigt shear modulus (GV, GPa) = %.2f\n",Gv);
printf("Reuss shear modulus (GR, GPa) = %.2f\n",Gr);
printf("Hill shear modulus (GH, GPa) = %.2f\n",Gh);
printf("\n")

Ev = 9 * Bv * Gv / (3 * Bv + Gv);
nuv = (3 * Bv - 2 * Gv) / 2 / (3 * Bv + Gv);
Er = 9 * Br * Gr / (3 * Br + Gr);
nur = (3 * Br - 2 * Gr) / 2 / (3 * Br + Gr);
Eh = 9 * Bh * Gh / (3 * Bh + Gh);
nuh = (3 * Bh - 2 * Gh) / 2 / (3 * Bh + Gh);

printf("Voigt Young modulus (EV, GPa) = %.2f\n",Ev);
printf("Reuss Young modulus (ER, GPa) = %.2f\n",Er);
printf("Hill Young modulus (EH, GPa) = %.2f\n",Eh);
printf("\n")

printf("Voigt Poisson ratio (nuV) = %.2f\n",nuv);
printf("Reuss Poisson ratio (nuR) = %.2f\n",nur);
printf("Hill Poisson ratio (nuH) = %.2f\n",nuh);
printf("\n")

## Sound velocities and Debye temperature
printf("## Polycrystal sound velocities and Debye temperature\n")
printf("# O. L. Anderson, A simplified method for calculating the Debye temperature from elastic constants,\n");
printf("# J. Phys. Chem. Solids 24 (1963) 909. https://doi.org/10.1016/0022-3697(63)90067-2\n");
vs = sqrt(Gh/rho) * 1000; # 1 sqrt(GPa / (g/cm^3)) = 1000 m/s
vl = sqrt((Bh + 4/3 * Gh)/rho) * 1000; # m/s
vm = (1/3 * (2/vs^3 + 1/vl^3))^(-1/3); # m/s
td = h/kb * (3*nat/(4*pi) * (NA*rho/molmass))^(1/3) * vm * 100; ## last 100, from m/s to cm/s
printf("Longitudinal sound velocity (vs, m/s) = %.2f\n",vl);
printf("Shear sound velocity (vl, m/s) = %.2f\n",vs);
printf("Average sound velocity (vm, m/s) = %.2f\n",vm);
printf("Debye temperature (TD, K) = %.2f\n",td);
printf("\n");

printf("## Axial compressibilities (standard setting)\n");
printf("# Nye, p. 146\n");

## Axial compressilibities:
## Convert to the standard setting and get the lattice vectors
name = tempname(".");
name = name(3:end);
fid = fopen(sprintf("%s.cri",name),"w");
fprintf(fid,"crystal %s\n",bfile);
fprintf(fid,"newcell standard\n");
fprintf(fid,"write %s.scf.in\n",name);
fclose(fid);
system(sprintf("critic2 %s.cri %s.cro",name,name));
[s out] = system(sprintf("grep -A 3 CELL_PARAMETERS %s.scf.in | tail -n 3",name));
system(sprintf("rm -f %s.cri %s.cro %s.scf.in",name,name,name));
rr = str2num(out);

str = {"a","b","c"};
for i = 1:3
  l = rr(i,:);
  l = l / norm(l);
  beta = (sij(1,1)+sij(1,2)+sij(1,3)) * l(1)*l(1) + (sij(1,6)+sij(2,6)+sij(3,6)) * l(1)*l(2) +...
         (sij(1,5)+sij(2,5)+sij(3,5)) * l(1)*l(3) + (sij(1,2)+sij(2,2)+sij(2,3)) * l(2)*l(2) +...
         (sij(1,4)+sij(2,4)+sij(3,4)) * l(2)*l(3) + (sij(1,3)+sij(2,3)+sij(3,3)) * l(3)*l(3);
  printf("%s axis: [%.5f %.5f %.5f]\n",str{i},l);
  printf("beta(%s) (GPa^{-1}) = %.7f\n",str{i},beta);
  printf("\n");
endfor

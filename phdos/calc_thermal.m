#! /usr/bin/octave -q

nat_funit = 3; ## number of atoms in the molecule/formula unit
h = 0.1; ## deltaE in all the phonon calculations (cm-1)
tref = 298.15; ## room temperature in Kelvin
kb = 3.166815d-6; ## Boltzmann constant, Ha/K
hy2cm_1 = 2.194746313705d5;
hy2kc = 627.50947;

## input done ##
## read the list of directories
[s out] = system("ls -d */");
alist = strsplit(out);
alist = alist(1:end-1);

## convert the step to hartree
h = h / hy2cm_1;

## header
printf("## All quantities in kcal/mol per unit formula or molecule.\n")

for i = 1:length(alist)
  ## check if either of the two phdos options exists
  name = alist{i}(1:end-1);
  file = sprintf("%s/crystal.phdos",name);
  if (!exist(file,"file"))
    file = sprintf("%s/%s.phdos",name,name);
    if (!exist(file,"file"))
      continue
    endif
  endif

  ## calculate z
  [s out] = system(sprintf("grep nat %s/%s.scf.in | cut -f 2 -d = | cut -f 1 -d ,",name,name));
  nat = str2num(out);
  z = nat / nat_funit;
  if (abs(z - round(z)) >= 1e-6)
    error(sprintf("Phase %s does not contain an integer number of formula units",name))
  endif

  ## read the phdos
  aa = load(file);

  ## convert units
  omega = aa(:,1) / hy2cm_1;
  gw = aa(:,2) * hy2cm_1;

  ## normalization
  nall_ini = trapz(gw) * h;
  nall_neg = trapz(gw(find(omega < 0))) * h;

  ## remove negative frequencies
  idx = find(omega > 0);
  omega = omega(idx);
  gw = gw(idx);
  gw = gw / (trapz(gw) * h) * (3 * nat);

  ## do the integration
  intg = (omega / 2 + kb * tref * log(1 - exp(-omega/kb/tref))) .* gw;
  fvib = trapz(intg) * h;

  intg = (omega / 2 + omega ./ (exp(omega/kb/tref) - 1)) .* gw;
  uvib = trapz(intg) * h;

  printf("| %s | Uvib = %.3f | Fvib = %.3f | norm(ini,neg,3*n) = %.2f,%.2f,%d |\n",...
         name,uvib/z*hy2kc,fvib/z*hy2kc,nall_ini,nall_neg,3*nat);
endfor

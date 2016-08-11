#! /usr/bin/octave-cli -q

## reference temperature - 25 C
tref = 298.15;

## number of atoms in the primitive unit cell
nat = 84;

### end of input block ###

format long;
kb = 3.166815d-6;
thz2cm_1 = 33.35641;
hy2cm_1 = 2.194746313705d5;
hybohr3togpa = 29421.0108037190;
nmodes = nat * 3;

## Read the phonon DOS
[s out] = system("grep -v '^#' total_dos.dat");
if (s != 0)
   error("total_dos.dat not found?")
endif
x = str2num(out);

## Discard the negative and zero frequencies
x = x(x(:,1) > 0,:);

## Convert to Hartree. Convert the phdos too in order
## to preserve phonopy's normalization.
f = x(:,1) * thz2cm_1 / hy2cm_1;
phdos = x(:,2) / thz2cm_1 * hy2cm_1;

## Normalization check
norm = trapz(f,phdos);
phdos = phdos / norm * nmodes;

## fvib calculation
intg = (f / 2 + kb * tref * log(1 - exp(-f/kb/tref))) .* phdos;
fvib = trapz(f,intg);

printf("Fvib (%.2f K) = %.10f Hartree\n",tref,fvib);


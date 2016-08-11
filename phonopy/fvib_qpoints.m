#! /usr/bin/octave-cli -q

## reference temperature - 25 C
tref = 298.15;

format long;
kb = 3.166815d-6;
thz2cm_1 = 33.35641;
hy2cm_1 = 2.194746313705d5;
hybohr3togpa = 29421.0108037190;

[s out] = system("grep frequency qpoints.yaml | awk '{print $NF}'");
if (s != 0)
   error("qpoints.yaml not found?")
endif
om = str2num(out);

## take out the first three frequencies
om = om(4:end);
om = om * thz2cm_1 / hy2cm_1;
fvib = sum(om / 2 + kb * tref * log(1 - exp(-om/kb/tref)));

printf("Fvib (%.2f K) = %.10f Hartree\n",tref,fvib);


#! /usr/bin/octave -q

function [U S G Tr Tv Uh Gh] = thermochem(x,Z,A,nu,sigma,T,p,e0=0);
  ## Calculate the molar thermodynamic properties of an ideal gas
  ## composed of molecules given in the input. x = coordinates in
  ## angstrom (nat rows and 3 columns). Z = atomic numbers. A = atomic
  ## masses in amu.  nu = vibrational frequencies in cm-1. sigma =
  ## rotational symmetry number.  T = temperature in K. p = pressure
  ## in bar. e0 = electronic energy in Hartree. In output: internal
  ## energy (U, kcal/mol), entropy (S, cal/K/mol), Gibbs free energy
  ## (G, kcal/mol), minus electronic contribution. Tr = rotational
  ## temperatures (K). Tv = vibrational temperatures (K). Uh = total
  ## internal energy in Hartree. Gh = total Gibbs free energy in
  ## Hartree

  ## some useful constants
  kth = 1.3806488e-23 * 298.15 / 6.62606957e-34; ## kT/h at RT (s-1)
  rt = 8.3144621 * 298.15 / 4.184 / 1000; ## RT at RT (kcal/mol)

  kb = 1.3806488e-23; ## J/K
  h = 6.62606957e-34; ## J.s
  NA = 6.02214129e23; ## mol^-1
  c = 299792458; ## m/s
  R = 8.3144621; ## J/K/mol

  ## molecular mass in amu and number of atoms
  nat = rows(x);
  m = sum(A);

  ## convert input to SI units
  m = m * 1.660539e-27; ## amu to kg
  p = p * 100000; ## bar to Pa 
  x = x * 1e-10; ## angstrom to m
  A = A * 1.660539e-27; ## amu to kg
  nu = nu * 100; ## cm-1 to m-1

  ## Translation ##
  lambda = h / sqrt(2 * pi * m * kb * T);
  V = kb * T / p;
  qtrans = V / lambda^3;
  Utrans = 3/2 * R * T;
  Strans = R * (log(qtrans) + 5/2);

  ## Rotation ##
#### inertia matrix and rotational temperature
  I = zeros(3);
  for i = 1:nat
    I(1,1) +=  A(i) * (x(i,2)**2 + x(i,3)**2);
    I(2,2) +=  A(i) * (x(i,1)**2 + x(i,3)**2);
    I(3,3) +=  A(i) * (x(i,1)**2 + x(i,2)**2);
    I(1,2) += -A(i) * x(i,1) * x(i,2);
    I(1,3) += -A(i) * x(i,1) * x(i,3);
    I(2,3) += -A(i) * x(i,2) * x(i,3);
  endfor
  Ieig = eig(I);
  Tr = h^2 ./ (8 * pi^2 * Ieig(find(abs(Ieig * 2.1350102e+47 > 1e-10))) * kb);
  if (length(Tr) < 2 || length(Tr) > 3)
    error("incorrect number of rotational temperatures")
  endif

  if (length(Tr) == 2)
#### linear
    qrot = 1 / sigma * (T / Tr(1));
    Urot = R * T;
    Srot = R * (log(qrot) + 1);
    islinear = 1;
  else
#### non-linear
    qrot = sqrt(pi) / sigma * sqrt(T^3 / prod(Tr));
    Urot = 3/2 * R * T;
    Srot = R * (log(qrot) + 3/2);
    islinear = 0;
  endif

  ## Vibration ##
  if (islinear && 3*nat-5 != length(nu) || !islinear && 3*nat-6 != length(nu))
    error("erroneous number of frequencies in input")
  endif
  Tv = h * c * nu / kb;
  Uvib = R * sum(Tv .* (1/2 + 1./(exp(Tv / T) - 1)));
  Svib = R * sum((Tv/T) ./ (exp(Tv/T)-1) - log(1 - exp(-Tv/T)));

  ## Electronic (assume mono-degenerate) ##
  Uel = 0;
  Sel = 0;

  ## calculate output
  U = Utrans + Urot + Uvib + Uel;
  S = Strans + Srot + Svib + Sel;
  pv = R * T;
  G = U + pv - T * S;
  Uh = e0 + U / 1000 / 4.184 / 627.50947;
  Gh = e0 + G / 1000 / 4.184 / 627.50947;

  ## convert output to calories
  U = U / 1000 / 4.184;
  S = S / 4.184;
  G = G / 1000 / 4.184;

endfunction

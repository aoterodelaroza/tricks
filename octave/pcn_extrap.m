function ecbs = pcn_extrap(e,n)
  %% Extrapolate the energy using the pc-n basis sets
  %% and the three-point formula, eq. 9 in
  %%   https://link.springer.com/article/10.1007/s00214-005-0635-2
  %% e and n are three-element vectors. e are the energies
  %% and n are the numbers in pc-n. The basis-sets used are
  %% pc-n, pc-(n+1), and pc-(n+2). Returns the CBS energy.

  C = -log((e(3)-e(1)) / (e(2)-e(1)) - 1);
  eC = exp(-C);
  eCn = exp(-C * (n+1));
  B = (e(2) - e(1)) / eCn / (eC - 1);
  ecbs = e(1) - B * eCn;

endfunction

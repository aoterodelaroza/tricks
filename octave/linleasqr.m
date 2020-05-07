#! /usr/bin/octave -q

function [m b sm sb] = linleasqr(x,y,wy=[],wx=[],r=[])
  %% function [m b sa sb] = linleasqr(x,y,wy=[],wx=[],r=[])
  %% 
  %% Linear least-squares fit of x to y with y-weights wy, x-weights
  %% wx, and correlation coefficients r. Uses Williamson-York method
  %% if wx is not empty or weighted linear least-squares fit if wx = [].
  %% Reduces to simple linear least-squares fit if wy = wx = r = [].
  %% Returns slope (m), intercept (b), and the uncertainties of slope
  %% (sigma_m) and intercept (sigma_b).
  %%
  %% References:
  %% R. J. Cvetanovic, D. L. Singleton, Comment on the evaluation of the Arrhenius parameters by the least squares method, Int. J. Chem. Kin. 9 (1977) 481.
  %% York et al., Unified equations for the slope, intercept, and standard errors of the best straight line, Am. J. Phys., 72 (2004) 367.
  %% C. A. Cantrell, Technical note: review of methods for linear least-squares fitting of data and application to atmospheric chemistry problems, Atmos. Chem. Phys. 8 (2008) 5477
  %% R. J. Cvetanovic et al., Evaluations of the mean values and standard errors of rate constantes and their temperature coefficients, J. Phys. Chem. 83 (1979) 50
  %% Faith A. Morrison, Obtaining uncertainty measures on slope and intercept of a least squares fit with excel's LINEST.
  %% R.E. Deakin and M.N. Hunter, Fitting a line of best fit to correlated data of varying precision
  

  %% sanity check
  x = x(:);
  y = y(:);
  if (length(x) != length(y))
    error("length(x) != length(y)")
  endif
  n = length(x);

  %% Non-iterative version. This is correct if wx = infty and r = 0.
  %% sanity check
  if (isempty(wy))
    wy = ones(n,1);
  else
    wy = wy(:);
    if (length(wy) != n)
      error("length(x) != length(wy)")
    endif
  endif

  sw = sum(wy);
  swx = sum(wy .* x);
  swy = sum(wy .* y);

  xm = swx / sw; ## mean of x
  ym = swy / sw; ## mean of y

  u = x - xm;
  v = y - ym;
  suv = sum(wy .* u .* v);
  su2 = sum(wy .* u .* u);

  m = suv / su2;
  b = ym - m * xm;

  sse = sum(wy .* (y - m * x - b).^2);
  sm = sqrt(sse / su2 / (n-2));
  sb = sqrt(sse / (n-2) * (1/n + xm^2 / su2));

  if (!isempty(wx))
    %% Iterative Williamson-York method. Use the m from the non-iterative
    %% version for the seed.
    wx = wx(:);

    %% correlation coefficients; assume uncorrelated if none provided
    if (isempty(r))
      r = zeros(n,1);
    else
      r = r(:);
    endif

    %% sanity check
    if (length(wx) != n)
      error("length(x) != length(wx)")
    endif
    if (length(r) != n)
      error("length(r) != length(wx)")
    endif

    mold = Inf;
    while (abs(m - mold) > 1e-9)
      alpha = sqrt(wx .* wy);
      w = wx .* wy ./ (wx + m^2 * wy - 2 * m * r .* alpha);

      sw = sum(w);
      swx = sum(w .* x);
      swy = sum(w .* y);

      xm = swx / sw;
      ym = swy / sw;

      u = x - xm;
      v = y - ym;

      beta = w .* (u ./ wy + m * v ./ wx - (m * u + v) .* r ./ alpha);
      mold = m;
      m = sum(w .* beta .* v) / sum(w .* beta .* u);
    endwhile
    b = ym - m * xm;

    bm = sum(w .* beta) / sw;
    sm = 1 / sum(w .* (beta - bm).^2);
    sb = 1/sw + (xm + bm)^2 * sm;
    sm = sqrt(sm);
    sb = sqrt(sb);
  endif

endfunction


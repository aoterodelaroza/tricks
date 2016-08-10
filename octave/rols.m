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

function [coef sigma r] = rols(y,x,alpha=0)
  %% function coef = rols(y,x,alpha=0)
  %%
  %% Least-squares method with penalty function on the norm of the coefficients.
  %% Find the coefficients (coef) that minimize:
  %%   |y - coef * x|^2 + alpha * |coef|^2
  %% Also known as "ridge regression" or "Tikhonov regularization".
  %% 
  %% x - an mxn matrix containing the fitting components.
  %% y - a mx1 matrix containing the target data.
  %% alpha - the weight of the penalty term. In the limit alpha=0,
  %%         rols() behaves the same as ols().
  %%
  %% coef - a nx1 matrix containing the least-squares coefficients.
  %% sigma - OLS estimator of the variance of the residuals:
  %%           sigma = |y - coef*x|^2 / (m - rank(x))
  %%         Its square root is the standard error of regression.
  %% r - the residuals, (y - coef * x)

  [u,s,v] = svd(x);
  sigma = diag(s);
  nr = rows(x);
  nc = columns(x);
  tol = max(nr,nc) * sigma(1) * eps;
  rnk = max(find(sigma > tol));
  if (isempty(rnk))
    xi = zeros(nr,nc);
  else
    u = u(:,1:rnk);
    s = diag(sigma(1:rnk) ./ (sigma(1:rnk).^2 + alpha));
    v = v(:,1:rnk);
    xi = v * s * u';
  endif
  coef = xi * y;

  if (isargout(2) || isargout(3))
    r = y - x * coef;
    if (isargout(2))
      sigma = r' * r / (nr - rnk);
    endif
  endif

endfunction

#! /usr/bin/octave -q

l = 3;
m = -1;

## nchoosek wrapper
function nc = nchoosek1(n,m)
  if (n > 0 && m <= n)
    nc = nchoosek(n,m);
  else
    nc = 1;
  endif
endfunction

## gamma coefficient
function g = gamma1(l,k,m)
  if (mod(k,2) == 1)
    sgn = -1;
  else
    sgn = 1;
  endif
  lnum = l - 2*k;
  lden = l - 2*k - m;
  if (lden <= 0 && lnum <= 0)
    prod = 1;
  elseif (lden <= 0)
    prod = factorial(lnum);
  else
    prod = prod(lden+1:lnum);
  endif
  g = sgn * 2^(-l) * nchoosek1(l,k) * nchoosek1(2*l-2*k,l) * prod;
endfunction

## build the mapping. There are nchoosek(3+l-1,l) combinations with repetition
if (m >= 0)
  sgn = 1
else
  sgn = -1
endif
m = abs(m);
temp = bsxfun(@minus, nchoosek(1:3+l-1,l), 0:l-1);
xyzlist = zeros(rows(temp),3);
coeflist = zeros(rows(xyzlist),1);
for i = 1:rows(xyzlist)
  xyzlist(i,1) = sum(temp(i,:) == 1);
  xyzlist(i,2) = sum(temp(i,:) == 2);
  xyzlist(i,3) = sum(temp(i,:) == 3);
endfor

## get the coefficients
for k = 0:floor((l-m)/2)
  for p = 0:m
    for i = 0:k
      for j = 0:i
        ix = 2 * j + p;
        iy = 2 * i - 2 * j + m - p;
        iz = l - m - 2 * i;

        if (ix + iy + iz != l)
          error("wrong sum of xyz exponents!")
        endif
        idx = find((xyzlist(:,1) == ix) & (xyzlist(:,2) == iy) & (xyzlist(:,3) == iz));
        if (!idx || idx == 0)
          error("cound not find idx!")
        endif

        if (m == 0)
          d = 1;
        else
          d = 0;
        endif
        if (sgn > 0)
          trig = cos((m-p) * pi/2);
        else
          trig = sin((m-p) * pi/2);
        endif
        coeflist(idx) += sqrt((2 - d) * factorial(l-m) / factorial(l+m)) * gamma1(l,k,m) * nchoosek(m,p) * trig;
      endfor
    endfor
  endfor
endfor

## print the results
for i = 1:rows(xyzlist)
  str = strcat(repmat("x",[1,xyzlist(i,1)]),repmat("y",[1,xyzlist(i,2)]),repmat("z",[1,xyzlist(i,3)]));
  printf("%s | %14.10f\n",str,coeflist(i));
endfor

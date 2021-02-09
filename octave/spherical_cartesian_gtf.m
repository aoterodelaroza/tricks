#! /usr/bin/octave -q

## Calculates the transformation matrix between spherical GTFs and Cartesian
## GTFs. Equation 15 in Schlegel & Frisch, https://doi.org/10.1002/qua.560540202

l = 4;

function c = calccoef(l,m,lx,ly,lz)
  c = 0;
  if (mod(lx + ly - abs(m),2) != 0)
    return
  endif
  if (m >= 0)
    sgn = 1;
  else
    sgn = -1;
  endif

  l = lx + ly + lz;
  j = (lx + ly - abs(m))/2;

  for i = 0:floor((l-abs(m))/2)
    if (j < 0 || j > i)
      continue
    endif
    fk = 0d0;
    for k = 0:j
      llx = lx - 2 * k;
      if (llx < 0 || llx > abs(m))
        continue
      endif
      fk = fk + nchoosek(j,k) * nchoosek(abs(m),llx) * (-1)^(sgn*floor((abs(m)-lx+2*k)/2));
    endfor
    c += fk * nchoosek(l,i) * nchoosek(i,j) * (-1)^i * factorial(2*l-2*i) / factorial(l - abs(m) - 2*i);
  endfor
  c *= sqrt(factorial(2*lx)*factorial(2*ly)*factorial(2*lz)*factorial(l)*factorial(l-abs(m)) / ...
            (factorial(2*l)*factorial(lx)*factorial(ly)*factorial(lz)*factorial(l+abs(m)))) / (2^l * factorial(l));
  if (m != 0)
    c *= sqrt(2);
  endif
endfunction

mat = zeros(nchoosek(3+l-1,l),2*l+1);
for m = -l:l
  ## build the mapping. There are nchoosek(3+l-1,l) combinations with repetition
  if (m >= 0)
    sgn = 1;
  else
    sgn = -1;
  endif
  temp = bsxfun(@minus, nchoosek(1:3+l-1,l), 0:l-1);
  xyzlist = zeros(rows(temp),3);
  coeflist = zeros(rows(xyzlist),1);
  for i = 1:rows(xyzlist)
    xyzlist(i,1) = sum(temp(i,:) == 1);
    xyzlist(i,2) = sum(temp(i,:) == 2);
    xyzlist(i,3) = sum(temp(i,:) == 3);
  endfor

  ## calculate the coefficients
  for k = 1:rows(xyzlist)
    lx = xyzlist(k,1);
    ly = xyzlist(k,2);
    lz = xyzlist(k,3);
    mat(k,m+l+1) = calccoef(l,m,lx,ly,lz);
  endfor
endfor

## print the results
printf("%*s | ",l,"");
for m = -l:l
  printf("%9d      ",m);
endfor
printf("\n");
for i = 1:rows(xyzlist)
  printf("%s | ",strcat(repmat("x",[1,xyzlist(i,1)]),repmat("y",[1,xyzlist(i,2)]),repmat("z",[1,xyzlist(i,3)])));
  for j = 1:columns(mat)
    printf("%14.10f ",mat(i,j));
  endfor
  printf("\n");
endfor

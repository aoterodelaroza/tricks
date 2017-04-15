#! /usr/bin/octave-cli

## test for the g primitives

I = @(n) (gamma((n+1)/2)); ## int_(-inf->inf) x^n * exp(-x^2)
ntot = 15;

alist = {"x","y","z"};
n = 0;
nn = zeros(1,3);
ixyz = zeros(6,ntot);
iidx = zeros(4,ntot);
names = {};
for i1 = 1:3
  for i2 = i1:3
    for i3 = i2:3
      for i4 = i3:3
        n++;
        names{n} = sprintf("%s%s%s%s",alist{i1},alist{i2},alist{i3},alist{i4});
        idx = [i1 i2 i3 i4];
        for i = 1:3
          nn(i) = sum(idx == i);
        endfor
        ixyz(1,n) = I(2*nn(1)+4) * I(2*nn(2)) * I(2*nn(3)); ## xx
        ixyz(2,n) = I(2*nn(1)) * I(2*nn(2)+4) * I(2*nn(3)); ## yy
        ixyz(3,n) = I(2*nn(1)) * I(2*nn(2)) * I(2*nn(3)+4); ## zz
        ixyz(4,n) = I(2*nn(1)) * I(2*nn(2)+2) * I(2*nn(3)+2); ## yz
        ixyz(5,n) = I(2*nn(1)+2) * I(2*nn(2)) * I(2*nn(3)+2); ## xz
        ixyz(6,n) = I(2*nn(1)+2) * I(2*nn(2)+2) * I(2*nn(3)); ## xy
        iidx(:,n) = idx;
      endfor
    endfor
  endfor
endfor

mpole = zeros(6,15);
for i = 1:ntot
  fid=fopen(sprintf("testg-%2.2d.gjf",i),"w");
  fprintf(fid,"#P HF gen 6D 10f nosymm guess=(core,cards) scfcyc=-1 iop(4/33=5) output=wfn\n");
  fprintf(fid,"\n");
  fprintf(fid,"test\n");
  fprintf(fid,"\n");
  fprintf(fid,"0 2\n");
  fprintf(fid,"H\n");
  fprintf(fid,"\n");
  fprintf(fid,"H 0\n");
  fprintf(fid,"g 1 1.0\n");
  fprintf(fid,"0.5 1.0\n");
  fprintf(fid,"****\n");
  fprintf(fid,"\n");
  fprintf(fid,"15E5.1\n");
  fprintf(fid,"1\n");
  for j = 1:ntot
    fprintf(fid,"%5.1f",i==j);
  endfor
  fprintf(fid,"\n");
  fprintf(fid,"15\n");
  for j = 1:ntot
    if (i < ntot)
      fprintf(fid,"%5.1f",j==ntot);
    else
      fprintf(fid,"%5.1f",j==1);
    endif
  endfor
  fprintf(fid,"\n");
  fprintf(fid,"\n");
  fprintf(fid,"\n");
  fprintf(fid,"testg-%2.2d.wfn\n",i);
  fprintf(fid,"\n");
  fclose(fid);
  printf("Running... testg-%2.2d.gjf\n",i);
  ## system(sprintf("g09 testg-%2.2d.gjf",i));
  [s out] = system(sprintf("grep -A 4 Hexadecapole testg-%2.2d.log | tail -n 4 | awk '{print $2,$4,$6,$8}' | tr ' ' '\n'",i));
  xx = str2num(out);
  mpole(1,i) = xx(1); # xx
  mpole(2,i) = xx(2); # yy
  mpole(3,i) = xx(3); # zz
  mpole(4,i) = xx(12); # yz
  mpole(5,i) = xx(11); # xz
  mpole(6,i) = xx(10); # xy
endfor

printf("\n## primitive order\n")
mpole = abs(mpole);
for k = 1:ntot
  max1 = max(mpole(:,k));
  r1 = max1 ./ mpole(:,k);
  found = 0;
  for i = 1:ntot
    max2 = max(ixyz(:,i));
    r2 = max2 ./ ixyz(:,i);
    if (all(abs(r1-r2)/max(max1,max2) < 1e-3))
      if (found) 
        error(sprintf("more than one found for %d %d",k,i));
      endif
      printf("%s\n",names{i});
      ## printf("%d,%d,%d,\n",sum(iidx(:,i)==1),sum(iidx(:,i)==2),sum(iidx(:,i)==3));
      found = 1;
    endif
  endfor
endfor


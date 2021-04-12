#! /usr/bin/octave -q

warning off
pkg load linear-algebra
pkg load matgeom
pkg load optim
pkg load statistics
warning on

## Transform a molecule by applying rotation rot and atom permutation phi.
function mol = transform_molecule(mol,rot=[],phi=[])

  if (!isempty(phi))
    mol.atname = mol.atname(phi);
    mol.atnumber = mol.atnumber(phi);
    mol.atmass = mol.atmass(phi);
    mol.atxyz = mol.atxyz(:,phi);
  endif

  if (!isempty(rot))
    mol.atxyz = rot * mol.atxyz;
  endif

endfunction

## for every transformed data point identify closest point in the model
function [dd,phi] = assign_points(m,zm,d,zd)
  nat = columns(m);
  used = phi = dd = zeros(1,nat);
  for i = 1:nat
    dmin = Inf;
    for j = 1:nat
      if (zd(i) == zm(j) && !used(j))
        distd = (m(:,j) - d(:,i))' * (m(:,j) - d(:,i));
        if (distd < dmin)
          dmin = distd;
          jmin = j;
        endif
      endif
    endfor
    dd(i) = dmin;
    phi(jmin) = i;
    used(jmin) = 1;
  endfor
endfunction

## align using PCA
function [mol rms0 rmsf] = pca_align(target,source)
  ## move to the center of mass
  cm = mol_cmass(target,1);
  target.atxyz = target.atxyz - cm * ones(1,target.nat);
  cm = mol_cmass(source,1);
  source.atxyz = source.atxyz - cm * ones(1,source.nat);

  ## initial alignment
  [~,~,rms0] = mol_align_walker(target,source);

  ## get the principal axes
  t0 = princomp(target.atxyz');
  t1 = princomp(source.atxyz');

  ## get the transformation matrices
  ri = t0 * inv(t1);
  rperm = {
       [ 1, 0, 0; 0  1 0; 0 0  1]
       [ 1, 0, 0; 0  1 0; 0 0 -1]
       [ 1, 0, 0; 0 -1 0; 0 0 -1]
       [ 1, 0, 0; 0 -1 0; 0 0  1]
       [-1, 0, 0; 0  1 0; 0 0  1]
       [-1, 0, 0; 0  1 0; 0 0 -1]
       [-1, 0, 0; 0 -1 0; 0 0 -1]
       [-1, 0, 0; 0 -1 0; 0 0  1]
  };

  ## get the point assignment
  phimin = rmin = [];
  eemin = Inf;
  for k = 1:8
    r = rperm{k} * ri;
    y = source.atxyz;
    for i = 1:source.nat
      y(:,i) = r * source.atxyz(:,i);
    endfor
    [dd,phi] = assign_points(target.atxyz,target.atnumber,y,source.atnumber);
    if (sum(dd) < eemin)
      eemin = sum(dd);
      phimin = phi;
      rmin = r;
    endif
  endfor
  mol = transform_molecule(source,rmin,phimin);

  ## final walker
  [~,~,rmsf] = mol_align_walker(target,mol);
endfunction


## read the molecules
mol0 = mol_readxyz("mol1h.xyz");
mol1 = mol_readxyz("mol2h.xyz");

## move to the center of mass
cm = mol_cmass(mol0,1);
mol0.atxyz = mol0.atxyz - cm * ones(1,mol0.nat);
cm = mol_cmass(mol1,1);
mol1.atxyz = mol1.atxyz - cm * ones(1,mol1.nat);

[molnew,rms0,rmsf] = pca_align(mol0,mol1);
rms0
rmsf

smol = mol_merge(mol0,molnew);
mol_writexyz(smol,"merge.xyz");

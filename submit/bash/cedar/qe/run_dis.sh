#! /bin/bash

run_dis(){
    cat >&3 <<EOM
##xx## For DIs:
srun pw.x < ${i}.pawscf.in > ${i}.pawscf.out
srun pp.x < ${i}.rhoae.in > ${i}.rhoae.out
srun pw.x < ${i}.scf.in > ${i}.scf.out
srun pp.x < ${i}.rho.in > ${i}.rho.out
srun open_grid.x < ${i}.opengrid.in > ${i}.opengrid.out

cat > ${i}.win <<EOG
num_wann = \$(grep states ${i}.scf.out | awk '{print \$NF}')
num_iter = 20000
conv_tol = 1e-4
conv_window = 3

begin unit_cell_cart
bohr
\$(grep -A 3 CELL_PARAM ${i}.scf.in | tail -n 3)
end unit_cell_cart

begin atoms_frac
\$(awk '/ATOMIC_POSITIONS/,/^ *\$/' ${i}.scf.in | tail -n+2 | head -n-1)
end atoms_frac

begin projections
random
end projections

search_shells = 24
kmesh_tol = 1d-3
mp_grid: \$(grep -A 1 POINTS ${i}.scf.in | tail -n 1  | awk '{print \$1, \$2, \$3}')
EOG
echo "begin kpoints" >> ${i}.win
awk '/List to be put/,/^ *$/' ${i}.opengrid.out | grep -v List | grep -v '^ *$' >> ${i}.win
echo "end kpoints" >> ${i}.win

/home/alberto/src/wannier90-2.1.0/wannier90.x -pp ${i}.win > ${i}.wout.1

module load intel/2017
srun pw2wannier90.x < ${i}.pw2wan.in > ${i}.pw2wan.out

export OMP_NUM_THREADS=1
/home/alberto/src/wannier90-2.1.0/wannier90.x ${i}.win > ${i}.wout.2

module load intel
module load fftw
\$A/pw2critic.x < ${i}.pw2critic.in > ${i}.pw2critic.out

export OMP_NUM_THREADS=\$SLURM_NTASKS
export CRITIC_HOME=/home/alberto/git/critic2
export OMP_STACKSIZE=128M
/home/alberto/bin/critic2 ${i}.cri ${i}.cro

EOM
}

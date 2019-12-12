#! /bin/bash

run_dis(){
    cat >&3 <<EOM
##xx## For DIs:
mpiexec --mca mpi_cuda_support 0 pw.x < ${i}.pawscf.in > ${i}.pawscf.out 2>&1
mpiexec --mca mpi_cuda_support 0 pp.x < ${i}.rhoae.in > ${i}.rhoae.out 2>&1
mpiexec --mca mpi_cuda_support 0 pw.x < ${i}.scf.in > ${i}.scf.out 2>&1
mpiexec --mca mpi_cuda_support 0 pp.x < ${i}.rho.in > ${i}.rho.out 2>&1
mpiexec --mca mpi_cuda_support 0 open_grid.x < ${i}.opengrid.in > ${i}.opengrid.out 2>&1

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

module load gcc/6.4.0
module load openblas/0.2.20
/home/alberto/src/wannier90-2.1.0/wannier90.x -pp ${i}.win > ${i}.wout.1

module load intel/2017
mpiexec --mca mpi_cuda_support 0 \${QE_HOME}/bin/pw2wannier90.x < ${i}.pw2wan.in > ${i}.pw2wan.out 2>&1

export OMP_NUM_THREADS=1
module load gcc/6.4.0
module load openblas/0.2.20
/home/alberto/src/wannier90-2.1.0/wannier90.x ${i}.win > ${i}.wout.2

module load intel
module load fftw
\${QE_HOME}/bin/pw2critic.x < ${i}.pw2critic.in > ${i}.pw2critic.out

module load gcc/6.4.0
export OMP_NUM_THREADS=${ncpu}
export CRITIC_HOME=/home/alberto/git/critic2
export OMP_STACKSIZE=128M
\${CRITIC_HOME}/src/critic2 ${i}.cri ${i}.cro

EOM
}

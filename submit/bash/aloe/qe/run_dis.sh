#! /bin/bash

run_dis(){
    cat >&3 <<EOM
## trick for making MKL think this is an intel processor
cat > trick.c <<EOF
int mkl_serv_intel_cpu_true() {
        return 1;
}
EOF
gcc -shared -fPIC -o libtrick.so trick.c

## instructions for MKL
export MKL_DEBUG_CPU_TYPE=5
export MKL_ENABLE_INSTRUCTIONS=AVX512

## run with srun to prevent overlap
export PMIX_MCA_psec=^munge
export PMIX_MCA_gds=^shmem2

##xx## For DIs:
LD_PRELOAD=./libtrick.so srun  \$A/pw.x < ${i}.pawscf.in > ${i}.pawscf.out
LD_PRELOAD=./libtrick.so srun  \$A/pp.x < ${i}.rhoae.in > ${i}.rhoae.out
LD_PRELOAD=./libtrick.so srun  \$A/pw.x < ${i}.scf.in > ${i}.scf.out
LD_PRELOAD=./libtrick.so srun  \$A/pp.x < ${i}.rho.in > ${i}.rho.out
LD_PRELOAD=./libtrick.so srun  \$A/open_grid.x < ${i}.opengrid.in > ${i}.opengrid.out

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

/opt/software/wannier90-2.1.0/wannier90.x -pp ${i}.win
mv ${i}.wout ${i}.wout.1

LD_PRELOAD=./libtrick.so srun  \$A/pw2wannier90.x < ${i}.pw2wan.in > ${i}.pw2wan.out

export OMP_NUM_THREADS=1
/opt/software/wannier90-2.1.0/wannier90.x ${i}.win
mv ${i}.wout ${i}.wout.2

\$A/pw2critic.x < ${i}.pw2critic.in > ${i}.pw2critic.out

export OMP_NUM_THREADS=${ncpu}
export CRITIC_HOME=/home/alberto/git/critic2
/opt/software/critic2/bin/critic2 ${i}.cri ${i}.cro
rm -f trick.c libtrick.so

EOM
}

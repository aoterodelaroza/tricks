!#! /bin/bash

run_dis(){
    cat >&3 <<EOM
##xx## For DIs:
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} \$ESPRESSO_HOME/bin/pw.x < ${i}.pawscf.in > ${i}.pawscf.out
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} \$ESPRESSO_HOME/bin/pp.x < ${i}.rhoae.in > ${i}.rhoae.out
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} \$ESPRESSO_HOME/bin/pw.x < ${i}.scf.in > ${i}.scf.out
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} \$ESPRESSO_HOME/bin/pp.x < ${i}.rho.in > ${i}.rho.out
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} \$ESPRESSO_HOME/bin/open_grid.x < ${i}.opengrid.in > ${i}.opengrid.out

cat > ${i}.win <<EOG
num_wann = \$(grep states ${i}.scf.out | awk '{print \$NF}')
num_iter = 20000

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

/opt/uovi/alberto/wannier90-2.0.1/wannier90.x -pp ${i}.win > ${i}.wout
mv ${i}.wout ${i}.wout.1
mv ${i}.werr ${i}.werr.1

/opt/openmpi/1.8.4/bin/mpirun -np ${ncpu} \$ESPRESSO_HOME/bin/pw2wannier90.x < ${i}.pw2wan.in > ${i}.pw2wan.out

/opt/uovi/alberto/wannier90-2.0.1/wannier90.x ${i}.win > ${i}.wout
mv ${i}.wout ${i}.wout.2
mv ${i}.werr ${i}.werr.2

\$ESPRESSO_HOME/bin/pw2critic.x < ${i}.pw2critic.in > ${i}.pw2critic.out

EOM
}

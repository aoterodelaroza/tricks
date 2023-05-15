#! /bin/bash

run_bfgs_critic2(){
    cat >&3 <<EOM

## initialize
if [ -f geometry.in.orig ] ; then
    cp -f geometry.in.orig geometry.in
else
    cp -f geometry.in geometry.in.orig
fi
if [ -f control.in.orig ] ; then
    cp -f control.in.orig control.in
else
    cp -f control.in control.in.orig
fi
cat > ${i}.cri <<EOF
trick bfgs geometry.in ${i}.bfgs ${i}.calc aims2
EOF
rm -fr ${i}.bfgs ${i}.calc

while true ; do
    ## initialize
    cat > control.in <<EOF
compute_forces .true.
compute_analytical_stress .true.
EOF
    sed -e '/^ *relax_geometry/d' -e '/^ *relax_unit_cell/d' control.in.orig >> control.in

    ## run it and generate the calc file
    mpirun /opt/software/FHIaims-220915_clean/build/aims.220915.mpi.x < /dev/null > ${i}.out

    grep '| Electronic free energy' ${i}.out | tail -n 1  | awk '{printf "%.14f\n",\$6*0.073498644}' > ${i}.calc
    grep -A 7 'Analytical stress tensor - Symmetrized' ${i}.out  | tail -n 3 | awk '{printf "%.14f %.14f %.14f\n",-\$3*0.010891375,-\$4*0.010891375,-\$5*0.010891375}' >> ${i}.calc
    awk '/Total atomic forces/,/^ *\$/' ${i}.out  | grep '|' | awk '{printf "%.14f %.14f %.14f\n",\$3*0.038893808, \$4*0.038893808, \$5*0.038893808}' >> ${i}.calc

    ## new bfgs step
    /opt/software/critic2/bin/critic2 ${i}.cri ${i}.cro
    if [ \$? -ne 0 ]; then
	break
    fi

    ## check convergence & exit
    if grep -q 'BFGS is CONVERGED' ${i}.cro ; then
	break
    fi
done
EOM
}

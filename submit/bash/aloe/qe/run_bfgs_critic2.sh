#! /bin/bash

run_bfgs_critic2(){
    cat >&3 <<EOM
function ssrun {
    export LD_PRELOAD=\$(pwd)/libtrick.so
    time srun \$@
    export LD_PRELOAD=
}

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
export MKL_CBWR=AUTO

## run with srun to prevent overlap
export PMIX_MCA_psec=^munge
export PMIX_MCA_gds=^shmem2

## initialize
cp -f ${i}.scf.in this.scf.in
cat > ${i}.cri <<EOF
trick bfgs this.scf.in ${i}.bfgs ${i}.calc tightqe
EOF
rm -fr ${i}.bfgs ${i}.calc

while true ; do
    ## make the new input file
    awk '/^&control\$/,/ATOMIC_POSITIONS/' ${i}.scf.in | head -n-1 > new.scf.in
    awk '/ATOMIC_POSITIONS/,/^ *\$/' this.scf.in >> new.scf.in
    awk '/K_POINTS/,/^ *\$/' ${i}.scf.in  >> new.scf.in
    awk '/CELL_PARAMETERS/,/^ *\$/' this.scf.in  >> new.scf.in
    mv new.scf.in this.scf.in

    ## run it and generate the calc file
    ssrun \$A/pw.x < this.scf.in > ${i}.scf.out
    grep ! ${i}.scf.out  | awk '{print \$5}' > ${i}.calc
    grep -A 3 'total   stress' ${i}.scf.out  | tail -n 3 | awk '{print \$1,\$2,\$3}' >> ${i}.calc
    grep '   force =' ${i}.scf.out  | awk '{print \$7,\$8,\$9}' >> ${i}.calc

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
rm -f trick.c libtrick.so
EOM
}

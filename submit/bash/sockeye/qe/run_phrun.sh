#! /bin/bash

run_phrun(){
    this=$(pwd)

    cat >&3 <<EOM

LOCKDIR="qpts.lock"
LIST="qpts.torun"
count=0
while true; do
    if [ ! -d \$LOCKDIR ] && mkdir \$LOCKDIR ; then
        touch \$LIST
        count=\$(wc -l \$LIST | awk '{print \$1}')
        if [ \$count -gt 0 ]; then
            njob=\$(head -n 1 \$LIST)
            tail -n+2 \$LIST > \$LIST.tmp.\$\$
            mv \$LIST.tmp.\$\$ \$LIST
        fi
        rm -rf \$LOCKDIR
        trap - INT TERM EXIT
	break
    fi
    sleep 1
done

## run the job
if [ \$count -gt 0 ] && [ ! -z \$njob ]; then
    tmpdir=\$(mktemp -d \$ESPRESSO_TMPDIR/tmp.XXXXXXXXXXX)
    rm -r \$tmpdir > /dev/null
    cp -r ${this}/${i}/ \$tmpdir
    cd \$tmpdir
    export ESPRESSO_TMPDIR=.

    sed "/&inputph/a\ start_q=\${njob},\n\ last_q=\${njob}," ${i}.ph.in > ${i}.ph.in_\${njob}
    mpiexec --mca mpi_cuda_support 0 ph.x < ${i}.ph.in_\${njob} > ${i}.ph.out_\${njob}

    cp -f ${i}.ph.out_\${njob} ${this}/${i}/
    cp -f _ph0/crystal.phsave/dynmat.\${njob}.*.xml ${this}/${i}/_ph0/crystal.phsave/
    if [ "\${njob}" == 1] ; then
      cp -f _ph0/crystal.phsave/tensors.xml ${this}/${i}/_ph0/crystal.phsave/
    fi
    cd ${this}/${i}
    rm -r \$tmpdir > /dev/null
fi
EOM
}


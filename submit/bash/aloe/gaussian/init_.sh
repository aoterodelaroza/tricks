#! /bin/bash

init_(){
    cat >&3 <<EOM
if [ -f /etc/sie_ladon ] ; then
    export g16root="/opt/software/g16A-sie_ladon"
elif [ -f /etc/sr630 ] ; then
    export g16root="/opt/software/g16A-sr630"
else
    echo "could not found ID file in /etc"
    exit
fi
echo "g16root = \$g16root"
export g16root="/opt/software"
. \$g16root/g16/bsd/g16.profile
export GAUSS_SCRDIR=\${SLURM_TMPDIR}

EOM
}

#! /bin/bash

run_bands(){
    cat >&3 <<EOM
##xx## For bands: run the nscf and bands.x
mpirun -np ${nmpi} pw.x < ${i}.nscf.in > ${i}.nscf.out
mpirun -np ${nmpi} bands.x < ${i}.bands.up.in > ${i}.bands.up.out
mpirun -np ${nmpi} bands.x < ${i}.bands.dn.in > ${i}.bands.dn.out

EOM
}

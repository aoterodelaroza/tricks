#! /bin/bash

## cluster details
cluster="sockeye"
walltime="10:00:00"
mem="8GB"
sbatchadd=""
ncpu="32"

## calc details
header="mpi" ## mpi, omp

what="qe"
variant="qe6" ## qe6 qegit
runlist="basic" ## basic opt phonons phstart phrun phend density hubbard bands dis...
clean="" ## noclean
#runlist="phstart phrun phend" 
#clean="noclean"

what="psi4"
variant="" 
runlist="" 
clean="" 

what="crystal"
variant="" 
runlist="" 
clean="" 

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh

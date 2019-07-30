#! /bin/bash

#! /bin/bash

## cluster details
cluster="cedar"
walltime="28-00:00"
mem="4000M"
ncpu="32"
sbatchadd=""

## calc details
what='crystal'
header='mpi'
variant=''
runlist=''

what='gaussian'
header='omp'
variant=''
runlist=''

what='psi4'
header='omp'
variant=''
runlist=''

what='qe'
header='mpi'
variant='qe6' ## qe6 myqe6 qegit
runlist='basic' ## basic opt hubbard density phonons bands dis

clean="" ## no-opts

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh


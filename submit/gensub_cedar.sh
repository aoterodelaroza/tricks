#! /bin/bash

## cluster details
cluster="cedar"
account="ctb-dilabiog" # ctb-dilabiog (priority) | rrg-dilabiog-ad (allocation)
walltime="28-00:00"
mempercpu="4000M"
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

what='elk'
variant=''
runlist=''

what='aimall'
variant=''
runlist=''

what='dftbp'
variant=''
runlist=''

what='qe'
header='mpi'
variant='qe6' ## qe6 qe65thermo myqe6 myqe6-ph qegit qegit-ph
runlist='basic' ## basic opt dos thermo hubbard density phonons bands dis

clean="" ## no-opts noclean

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh


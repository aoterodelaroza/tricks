#! /bin/bash

## cluster details
cluster="graham"
walltime="0-12:00" ## 0-3:00 | 0-12:00 | 1-00:00:00 | 3-00:00:00 | 7-00:00:00 | 28-00:00:00
mem="64G"
ncpu="32"
sbatchadd=""

## calc details
what='gaussian'
header=''
variant=''
runlist=''

what='qe'
header='mpi'
variant='qe6' ## qe6 qe65thermo
runlist='basic' ## basic opt dos hubbard density phonons bands

clean="" ## no-opts noclean

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh


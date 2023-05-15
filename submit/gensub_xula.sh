#! /bin/bash

## cluster details
cluster="xula"
walltime="3-00:00"
nnode="1"
ncpu="40"

## calc details
# what='orca'
# header='mpi'
# variant=''
# runlist=''
# clean=''
#
# what='fhiaims'
# header='mpi'
# variant='' # old
# runlist=''
# clean=''
#
# what='qe'
# header='mpi'
# variant='' ## qe65thermo
# runlist='basic' ## basic thermo neb opt hubbard density phonons bands dis dos
# clean=''

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh

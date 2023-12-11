#! /bin/bash

## cluster details
cluster="sama"
nnode="1"
ncpu="48"
sbatchadd=""

# ## calc details
# what='fhiaims'
# header='mpi' ## <empty> omp mpi exclusive
# variant=''
# runlist='basic' ## basic bfgs_critic2
# clean=''
#
# what='qe'
# header='mpi' ## <empty> omp mpi exclusive
# variant='qe65thermo' ## qe65thermo
# runlist='basic opt' ## basic opt
# clean='' ## <empty> noclean
#
# what='vasp'
# header='mpi' ## <empty> omp mpi exclusive
# variant=''
# runlist=''
# clean='' ## <empty> noclean

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh

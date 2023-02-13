#! /bin/bash

## cluster details
cluster="aloe"
nnode="1"
ncpu="20"
sbatchadd=""

# ## calc details
# what='orca'
# header='mpi' # exclusive
# variant=''
# runlist=''
# clean=''
#
# what='gaussian'
# header='omp' # exclusive
# variant=''
# runlist='' ## <empty> pack
# clean='' ## <empty> acpterms
#
# what='fhiaims'
# header='mpi' # exclusive
# variant=''
# runlist='basic' ## basic bfgs_critic2
# clean=''
#
# what='qe'
# header='mpi' # exclusive
# variant='qe65thermo' ## qe6 qe65thermo myqe6 myqe6-ph qegit qegit-ph
# runlist='basic' ## basic opt dos thermo hubbard density phonons bands dis bfgs_critic2
# clean='' ## <empty> noclean
#
# what='ase'
# header='mpi' # exclusive
# variant='aims' ## aims
# runlist=''
# clean=''
#
# what='mrcc'
# header='omp' # exclusive
# variant=''
# runlist=''
# clean=''

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh

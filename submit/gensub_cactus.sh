#! /bin/bash

## cluster details
cluster="cactus"
nnode="1"
ncpu="8"
sbatchadd=""

# ## calc details
# what='fhiaims'
# header='mpi' # exclusive
# variant=''
# runlist='basic' ## basic bfgs_critic2
# clean=''
#
# what='qe'
# header='mpi' # exclusive
# variant='qe65thermo qe731' ## qe65thermo qe731
# runlist='basic' ## basic opt dos thermo hubbard density phonons bands dis bfgs_critic2
# clean='' ## <empty> noclean
#

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh

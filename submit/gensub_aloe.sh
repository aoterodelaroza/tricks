#! /bin/bash

## cluster details
cluster="aloe"
nnode="1"
ncpu="20"
sbatchadd=""

# ## calc details
# what='gaussian'
# header='omp'
# variant=''
# runlist='' ## <empty> pack
# clean='' ## <empty> acpterms
#
# what='fhiaims'
# header='mpi'
# variant=''
# runlist=''
# clean=''
#
# what='qe'
# header='mpi'
# variant='qe65thermo' ## qe6 qe65thermo myqe6 myqe6-ph qegit qegit-ph
# runlist='basic' ## basic opt dos thermo hubbard density phonons bands dis
# clean='' ## <empty> noclean

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh

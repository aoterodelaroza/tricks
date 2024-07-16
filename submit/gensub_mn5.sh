#! /bin/bash

## cluster details
cluster="mn5"
nnode="1"
ncpu="28"
walltime="0-12:00:00" ## 3-00:00:00
sbatchadd=""

# ## calc details
# what='fhiaims'
# header='mpi' # mpi highmem
# variant=''
# runlist=''
# clean=''
# 
# what='qe'
# header='mpi' # mpi highmem
# variant='qe731' ## qe65thermo qe72 qe731
# runlist='basic' ## basic opt dos hubbard density phonons bands
# clean='' ## <empty> noclean

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh

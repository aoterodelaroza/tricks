#! /bin/bash

## cluster details
cluster="cactus"
nnode="1"
ncpu="8"
sbatchadd=""

# ## calc details
# what='qe'
# header='mpi' # mpi exclusive
# variant='qe65thermo' ## qe65thermo qe731
# runlist='basic' ## basic opt
# clean='' ## <empty> noclean
#
# what='fhiaims'
# header='mpi' # mpi exclusive
# variant='251014' # 251014
# runlist=''
# clean=''
#
# what='gaussian'
# header='omp' # exclusive
# variant='g16a' ## g16a
# runlist='' ## <empty> pack scratch
# clean='' ## <empty> acpterms
#
# what='hiphive'
# header='omp' # exclusive
# variant=''
# runlist=''
# clean=''
#
# what='crystal'
# header='mpi' # exclusive
# variant=''
# runlist=''
# clean=''
#
# what='orca'
# header='mpi' # exclusive
# variant=''
# runlist=''
# clean=''
#
# what='elk'
# header='mpi' # exclusive
# variant=''
# runlist='' ## basic bfgs_critic2
# clean=''
#

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh

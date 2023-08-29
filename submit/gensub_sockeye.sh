#! /bin/bash

## cluster details
cluster="sockeye"
walltime="7:00:00"
mem="144GB"
sbatchadd=""
ncpu="32"

# ## calc details
# what="qe"
# header="mpi"
# variant="qe6" ## qe6 qegit
# runlist="basic" ## basic opt density ...
# clean="" ## noclean
# 
# what="psi4"
# header="omp"
# variant=""
# runlist=""
# clean="" ## noclean
# 
# what="crystal"
# header="mpi"
# variant=""
# runlist=""
# clean="" ## noclean
# 
# what="orca"
# header="mpi"
# variant=""
# runlist=""
# clean="" ## noclean

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh

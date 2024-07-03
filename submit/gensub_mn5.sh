#! /bin/bash

## cluster details
cluster="mn5"
nnode="1"
ncpu="28"
walltime="0-12:00:00" ## 3-00:00:00
sbatchadd=""

# ## calc details
# what='fhiaims'
# header='mpi' # exclusive
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

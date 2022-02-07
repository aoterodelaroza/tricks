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

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh

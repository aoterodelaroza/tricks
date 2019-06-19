#! /bin/bash

## cluster details
cluster="malta"

## queue
header="p8"
ncpu="8"

#header="p12"
#ncpu="12"

#header="sub"
#ncpu="20"

## calc details
what='qe'
variant='qe6' ## qe5 qe4 qe6 qegit
runlist='basic' ## basic opt hubbard density phonons bands dis

#what='gaussian'
#variant=''
#runlist=''
#
#what='aimall'
#variant=''
#runlist=''
#
#what='crystal'
#variant=''
#runlist=''
#
#what='elk'
#variant=''
#runlist=''
#
#what='vasp'
#variant=''
#runlist=''

clean="" ## no-opts

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh

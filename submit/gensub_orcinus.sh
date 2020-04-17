#! /bin/bash

## cluster details
cluster="orcinus"
walltime="240:00:00"
mem="8GB"
sbatchadd=""
ncpu="4"

## calc details
header="" ## no-opts
what="qe" 
variant="qemodule" ## qemodule qegit qe61 qe65thermo
runlist="basic" ## basic opt density ...

## header="" ## no-opts
## what="gaussian" 
## variant="" 
## runlist="" 

clean="" ## no-opts

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh

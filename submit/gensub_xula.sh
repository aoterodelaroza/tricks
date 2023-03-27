#! /bin/bash

## cluster details
cluster="xula"

## number of cpus
ncpu="40"

## calc details

# what='qe'
# variant='' ## qe65thermo
# runlist='basic' ## basic thermo neb opt hubbard density phonons bands dis dos

clean="" ## no-opts noclean

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh

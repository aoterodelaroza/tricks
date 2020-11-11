#! /bin/bash

## cluster details
cluster="calendula"

## number of cpus
ncpu="8"

## calc details
what='qe'
variant='qe65thermo' ## qe65thermo qe66module
runlist='basic' ## basic thermo neb opt hubbard density phonons bands dis dos

clean="" ## no-opts noclean

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh


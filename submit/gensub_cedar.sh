#! /bin/bash

## cluster details
cluster="cedar"
account="ctb-dilabiog" # ctb-dilabiog (priority) | rrg-dilabiog-ad (allocation)
walltime="28-00:00"
mempercpu="4000M"
ncpu="32"
sbatchadd=""

# ## calc details
# what='gaussian'
# header='omp'
# variant=''
# runlist='pack' ## <empty> pack
# clean='' ## <empty> acpterms
#
# what='qe'
# header='mpi'
# variant='qe6' ## qe6 qe65thermo myqe6 myqe6-ph qegit qegit-ph
# runlist='basic' ## basic opt dos thermo hubbard density phonons bands dis
# clean='' ## <empty> noclean
#
# what='psi4'
# header='omp'
# variant=''
# runlist=''
# clean=''
#
# what='elk'
# header='omp'
# variant=''
# runlist=''
# clean=''
#
# what='aimall'
# header='omp'
# variant=''
# runlist=''
# clean=''
#
# what='dftbp'
# header='omp'
# variant=''
# runlist=''
# clean=''
#
# what='xtb'
# header='omp'
# variant='gfn1' ## gfn1 gfn2
# runlist='opt' ## basic opt
# clean='' ## <emtpy> noclean
#
# what='orca'
# header='omp'
# variant='' ## myorca 421
# runlist=''
# clean=''
#
# what='mrcc'
# header='omp'
# variant=''
# runlist=''
# clean=''
#
# what='crystal'
# header='mpi'
# variant=''
# runlist=''
# clean=''
#
# what='fhiaims'
# header='mpi'
# variant=''
# runlist=''
# clean=''
#

#### END OF INPUT ####

dirloc="~/git/tricks/submit"
eval dirloc=$dirloc
location="${dirloc}/bash/${cluster}"
localname="${0%.sh}_local.sh"
jobext="sub"

. ${dirloc}/main.sh

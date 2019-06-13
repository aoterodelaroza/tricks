#! /bin/bash

#### program and run options ####
what="qe"
variant="qe6"
runlist="basic density" ## basic density phonons dis bands opt hubbard
clean=""
#what="gaussian"
#what="crystal"

#### cluster info ####
# cluster="cedar"
# header="mpi"
# #header="omp"
# walltime="28-00:00"
# mem="4000M"
# ncpu="32"
# sbatchadd=""
# 
# cluster="orcinus"
# walltime="240:00:00"
# mem="8GB"
# sbatchadd=""
# ncpu="4"

cluster="malta"
header="p8"
#header="p12"
#header="sub"
ncpu="8"
sbatchadd=""

#### INPUT ENDS HERE ####

## location of the source scripts, and local name
location="~/git/tricks/submit/bash/${cluster}"
localname="local.sh"
jobext="sub"

printusage(){
    cat <<EOF

  -h: this help
  -s <n>: run <n> calcs in serial
  -p <n>: run <n> calcs in parallel
  -g: create a script in the current directory (local.sh) that contains a copy
      of all functions used for the current run. If the local.sh script is
      already present, read the functions from it instead of $location.

EOF
    echo "## List of script generators:"
    echo "header='$(ls -d ${location}/*.sh | rev | cut -f 1 -d / | rev | grep -v header.sh | cut -f 2 -d _ | cut -f 1 -d . | tr '\n' ' ' | sed 's/[[:space:]]*$//g')'"
    listwhat=$(ls -d ${location}/*/ | rev | cut -f 2 -d / | rev | tr '\n' ' ' | sed 's/[[:space:]]*$//g')
    for i in $listwhat ; do
	echo "what='$i'"
	echo "variant='$(find ${location}/${i}/ -name 'init_*sh' | rev | cut -f 1 -d / | rev | cut -f 2 -d _ | cut -f 1 -d . | tr '\n' ' ' | sed 's/[[:space:]]*$//g')'"
	echo "runlist='$(find ${location}/${i}/ -name 'run_*sh' | rev | cut -f 1 -d / | rev | cut -f 2 -d _ | cut -f 1 -d . | tr '\n' ' ' | sed 's/[[:space:]]*$//g')'"
	echo ""
    done
}

function writelocal(){
    grep -v '^#' ${location}/header_${header}.sh > ${localname}
    grep -v '^#' ${location}/${what}/init_${variant}.sh >> ${localname}
    grep -v '^#' ${location}/${what}/list_.sh >> ${localname}
    if [ -z "${runlist}" ] ; then
	grep -v '^#' ${location}/${what}/run_.sh >> ${localname}
    else
	for i in $runlist ; do 
	    grep -v '^#' ${location}/${what}/run_${i}.sh >> ${localname}
	done
    fi
    grep -v '^#' ${location}/${what}/clean_${clean}.sh >> ${localname}
}

function check_and_source(){
    if [ -z "$2" ] ; then
	test -f "${location}/${1}.sh" || { echo "ERROR: ${location}/${1}.sh not found"; exit 1; }
	. ${location}/${1}.sh
    else
	test -f "${location}/${1}/${2}.sh" || { echo "ERROR: ${location}/${1}/${2}.sh not found"; exit 1; }
	. ${location}/${1}/${2}.sh
    fi
}

main() {
    # init
    local ser=""
    local par=""
    local genlocal=""

    # read arguments to the function
    local OPTSTRING=${@}
    local OPTIND=1
    while getopts ":s:p:g" opt 
    do
	case $opt in
	    s) ser=$OPTARG ;;
	    p) par=$OPTARG ;;
	    g) genlocal=1 ;;
	    ?) printusage ; exit 0 ;;
	esac
    done
    shift $((OPTIND-1))

    if [ -n "$genlocal" ] ; then
	if [ -f "${localname}" ]; then
	    . ${localname}
	else
	    echo "Writing ${localname}..."
	    writelocal
	    exit 0
	fi
    fi

    # packing number
    local AMP
    local -i npack n m
    if [ -n "$ser" ]; then
	npack=$ser
	AMP=""
    elif [ -n "$par" ]; then
	npack=$par
	AMP="&"
    else
	AMP=""
	npack=1
    fi
    n=$((npack-1))

    # build list of systems
    list_
    if [ -z "$list" ]; then
	echo "ERROR: the list is empty (extension=${extension})"
	exit 1
    fi
    m=0
    local name i
    for ii in $list ; do
	i=${ii%${extension}}
	n=$((n+1))

	## write header for this job, maybe
	if ((n == npack)) ; then
	    m=$((m+1))
	    if ((npack > 1)) ; then
		name=$(basename $PWD)_${m}.${jobext}
	    else
		name=${i}.${jobext}
	    fi
	    n=0
	    echo $(pwd)/${name}

	    ## close last file and connect new one
	    if ((m > 1)); then
		if [ -n "${par}" ] ; then
		    echo "wait" >&3
		fi
		exec 3>&-
	    fi
	    exec 3> $name

	    ## write the header
	    header_${header}

	    ## initialization code
	    init_${variant}
	fi

	## go to the correct directory
	if [ "${extension:-1}" == "/" ] ; then
	    echo "cd $(pwd)/${i}" >&3
	else
	    echo "cd $(pwd)/" >&3
	fi

	## run the calculation
	if [ -z "${runlist}" ] ; then
	    run_
	else
	    for j in $runlist ; do 
		run_${j}
	    done
	fi

	## clean up
	clean_${clean}
    done

    if [ -n "${par}" ] ; then
	echo "wait" >&3
    fi
    exec 3>&-
}

## check the source scripts exist and read them
eval location=$location
test -d "${location}/${what}" || { echo "ERROR: ${location}/${what} dir not found"; exit 1; }
check_and_source "header_${header}"
check_and_source "${what}" "init_${variant}"
check_and_source "${what}" "list_"
if [ -z "${runlist}" ] ; then
    check_and_source "${what}" "run_"
else
    for i in $runlist ; do 
	check_and_source "${what}" "run_${i}"
    done
fi
check_and_source "${what}" "clean_${clean}"

## run the thing
main "$@"


#! /bin/bash

## Prepare phonon calculations at the equilibrium geometry using
## phonopy, QE version. The directory where this script is located
## should contain a number of subdirectories, one for each crystal to
## calculate. Each subdirectory should contain:
##   bleh/bleh.scf.in - the input file containing the equilibrium
##                      geometry.
##   bleh/bleh.scf.out - the output file at the equilibrium geometry.
##   bleh/*.UPF - the pseudopotentials.
##
## Requirements:
## - phonopy should be in the PATH
## 

## Dimensions of the supercell - determines the quality of the 
## calculated phonon frequencies. Larger is better, but all force
## calculations involve a supercell with dim(1)*dim(2)*dim(3)*nat
## atoms, with nat the number of atoms in the primitive.
dim="1 1 1"

### end of input block ###

for ii in */ ; do 
    i=${ii%/}
    cd $i
    if [ -f ${i}.scf.in ] ; then
	## clean up the scf.in
	sed 's/^ *//' ${i}.scf.in | sed -e "s/\b\(.\)/\u\1/" > phon.scf.in 

	## write the inputs for phonopy
	atomlist=$(grep UPF phon.scf.in | awk '{print $1}' | tr '\n' ' ')

	## Write the prephon file
	cat > prephon.conf <<EOF
DIM = $dim
CREATE_DISPLACEMENTS = .TRUE.
ATOM_NAME = ${atomlist}
CELL_FILENAME = phon.scf.in
EOF

	## Write the postphon file
	cat > postphon1.conf <<EOF
DIM = $dim
MP=31 31 31
ATOM_NAME = ${atomlist}
CELL_FILENAME = phon.scf.in
DOS=.TRUE.
DOS_RANGE=0 150 0.1
WRITE_MESH=.FALSE.
TPROP=.TRUE.
TMIN=298.15
TMAX=298.15
EOF

	## Write the postphon file
	cat > postphon2.conf <<EOF
DIM = $dim
ATOM_NAME = ${atomlist}
CELL_FILENAME = phon.scf.in
QPOINTS=.TRUE.
EOF

	## Write the QPOINTS file
	cat > QPOINTS <<EOF
1
0. 0. 0.
EOF
	phonopy --pwscf prephon.conf

	for jj in supercell-*in ; do
	    nat=$(grep nat $jj | cut -f 3 -d = | awk '{print $1+0}')
	    sname=${jj%.in}
	    sname=${i}-${sname#supercell-}
	    mkdir $sname
	    cat > ${sname}/${sname}.scf.in <<EOF
$(awk '/&control/,/\//' ${i}.scf.in | grep -v calculation | awk 'NR==2{print " tprnfor=.true.,"}{print}')
$(awk '/&system/,/\//' ${i}.scf.in | grep -v celldm | sed -e 's/^.*\(nat *=\).*$/ \1'$nat',/')
$(awk '/&electrons/,/\//' ${i}.scf.in)
$(grep -A 1 K_POINTS ${i}.scf.in)
$(cat $jj)
EOF
	    cp -f *UPF ${sname}/
	    rm -f $jj
	done
    else
	echo "skipping : ${i} (no scf.in)"
    fi
    cd ..
done

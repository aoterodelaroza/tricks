#! /bin/bash

for ii in $(cat aa) ; do 
    i=${ii%/}
    cd $i
    if [ -f ${i}.scf.in ] ; then
	## clean up the scf.in
	sed 's/^ *//' ${i}.scf.in | sed -e "s/\b\(.\)/\u\1/" > phon.scf.in 

	## write the inputs for phonopy
	atomlist=$(grep UPF phon.scf.in  | awk '{print $1}' | atom2Z.awk  | Z2name.awk | tr '\n' ' ')

	cat > prephon.conf <<EOF
DIM = 1 1 1
CREATE_DISPLACEMENTS = .TRUE.
ATOM_NAME = ${atomlist}
CELL_FILENAME = phon.scf.in
EOF

	cat > postphon.conf <<EOF
DIM = 1 1 1
ATOM_NAME = ${atomlist}
CELL_FILENAME = phon.scf.in
MP=31 31 31
DOS=.TRUE.
DOS_RANGE=0 150 0.1
WRITE_MESH=.FALSE.
TPROP=.TRUE.
TMIN=298.15
TMAX=298.15
EOF
	phonopy --pwscf prephon.conf

	for jj in supercell-*in ; do
	    sname=${jj%.in}
	    mkdir $sname
	    nat=$(grep '!' ${jj} | cut -f 3 -d = | awk '{print $1+0}')
	    cat > ${sname}/${sname}.scf.in <<EOF
$(awk '/&control/,/\//' ${i}.scf.in | grep -v calculation | awk 'NR==2{print " tprnfor=.true.,"}{print}')
$(awk '/&system/,/\//' ${i}.scf.in | grep -v celldm | sed -e "s/nat=.*,/nat=${nat}/")
$(awk '/&electrons/,/\//' ${i}.scf.in)
$(grep -A 1 K_POINTS ${i}.scf.in)
$(cat $jj)
EOF
	    cp -f *UPF ${sname}/
	    rm -f $jj
	done
	
	rm -f phon.scf.in
    else
	echo "skipping : ${i} (no scf.in)"
    fi
    cd ..
done

#! /bin/bash

for ii in */ ; do 
    i=${ii%/}
    cd $i
    sed 's/^ *//' ${i}.scf.in | sed -e "s/\b\(.\)/\u\1/" > phon.scf.in 
    for j in ${i}-*/ ; do 
	jj=${j#*-}
	cp -f ${j}${j%/}.scf.out supercell-${jj%/}.out 
    done
    phonopy --pwscf -f supercell-*.out
    phonopy --pwscf postphon1.conf
    phonopy --pwscf postphon2.conf
    cd ..
done

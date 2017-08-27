#! /bin/bash

TES="tessel"
tempfile="__tempfile.$$.tess"
tempout="__tempfile.$$.out"
tempout2="__tempfile.$$.out2"

if [ -z $(which ${TES}) ] ; then
    echo " Tessel not found : ${TES}"
    #return
    exit
fi

lattic=$(head -n 2 ${1} | tail -n 1 | cut -c 1-4)

cat > ${tempfile} <<EOF
molecule
 crystal
  struct $1
  crystalbox -3.05 -3.05 -3.05 3.05 3.05 3.05
  clippingbox -0.05 -0.05 -0.05 1.05 1.05 1.05
 endcrystal
EOF

str=""
if [ "${lattic:0:3}" == "CXY" ] ; then
    str="center 0 0 0 vec1 0.5 0.5 0 vec2 -0.5 0.5 0 vec3 0 0 1"
elif [ "${lattic:0:3}" == "CXZ" ] ; then
    str="center 0 0 0 vec1 0.5 0 0.5 vec2 -0.5 0 0.5 vec3 0 1 0"
elif [ "${lattic:0:3}" == "CYZ" ] ; then
    str="center 0 0 0 vec1 0 0.5 0.5 vec2 0 -0.5 0.5 vec3 1 0 0"
elif [ "${lattic:0:1}" == "B" ] ; then
    str="center 0 0 0 vec1 -0.5 0.5 0.5 vec2 0.5 -0.5 0.5 vec3 0.5 0.5 -0.5"
elif [ "${lattic:0:1}" == "F" ] ; then
    str="center 0 0 0 vec1 0.5 0.5 0 vec2 0.5 0 0.5 vec3 0 0.5 0.5"
fi

cat >> ${tempfile} <<EOF
 newunitcell ${str}
endmolecule
end
EOF

${TES} ${tempfile} > ${tempout}
rm -f ${tempfile}

# abinit template
acell=$(grep 'New cell size' ${tempout} | cut -f 2 -d ':')
angdeg=$(grep 'New cell angles' ${tempout} | cut -f 2 -d ':')
awk '
/List of atoms that would/{
 getline; getline;
 for(;$0 !~ /^( |\t)*$/;getline)
   print substr($0,7,36), $(NF-1), $NF
}
' ${tempout} > ${tempout2}
znucl=$(awk '
{ 
 if (!a[$NF]) {
   str="echo " $NF " | atom2Z.awk"
   str | getline num
   close(str)
   add = add " " num
 }
 a[$NF] = 1 
}
END{
  print add
}
' ${tempout2})
ntypat=$(echo "${znucl}" | wc | awk '{print $2+0}')
natom=$(wc ${tempout2} | awk '{print $1+0}')
typat=""
for i in $(cat ${tempout2} | awk '{print $4}') ; do
    typat="${typat} ${i}"
done
cat <<EOF
# template created by struct2ab.sh

# Unit cell
acell ${acell}
angdeg ${angdeg}

# Definition of the atoms
ntypat ${ntypat}
znucl ${znucl}
natom ${natom}
typat ${typat}
EOF

printf "xred " 
cat ${tempout2} | awk '{printf "%.12f %.12f %.12f\n",$1,$2,$3}'

cat <<EOF

# xc
ixc 1

# basis
ecut 6

# kpt
kptopt 1
nshiftk 1
shiftk 0.5 0.5 0.5
ngkpt 4 4 4

# scf 
nstep 40
toldfe 1.0d-10
diemac 4.0

# print levels
prtgeo 10
prtelf 1

########
# spin
# spinat 0.0 0.0 4.0
# nsppol 2

# opt
#optcell 1
#ionmov 3
#ntime 10
#dilatmx 1.05
#ecutsm 0.5

# enlarge fft grid for density analysis
#ndtset 2
#prtden1 0
#getwfk2 1
#ngfft2 3*200
#nstep2 0

EOF

#rm -f ${tempout} ${tempout2}

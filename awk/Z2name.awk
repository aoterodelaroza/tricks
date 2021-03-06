#! /usr/bin/awk -f

BEGIN{
    const_atomicname[  0] = "Bq"
    const_atomicname[  1] = "H" 
    const_atomicname[  2] = "He"
    const_atomicname[  3] = "Li"
    const_atomicname[  4] = "Be"
    const_atomicname[  5] = "B" 
    const_atomicname[  6] = "C" 
    const_atomicname[  7] = "N" 
    const_atomicname[  8] = "O" 
    const_atomicname[  9] = "F" 
    const_atomicname[ 10] = "Ne"
    const_atomicname[ 11] = "Na"
    const_atomicname[ 12] = "Mg"
    const_atomicname[ 13] = "Al"
    const_atomicname[ 14] = "Si"
    const_atomicname[ 15] = "P" 
    const_atomicname[ 16] = "S" 
    const_atomicname[ 17] = "Cl"
    const_atomicname[ 18] = "Ar"
    const_atomicname[ 19] = "K" 
    const_atomicname[ 20] = "Ca"
    const_atomicname[ 21] = "Sc"
    const_atomicname[ 22] = "Ti"
    const_atomicname[ 23] = "V" 
    const_atomicname[ 24] = "Cr"
    const_atomicname[ 25] = "Mn"
    const_atomicname[ 26] = "Fe"
    const_atomicname[ 27] = "Co"
    const_atomicname[ 28] = "Ni"
    const_atomicname[ 29] = "Cu"
    const_atomicname[ 30] = "Zn"
    const_atomicname[ 31] = "Ga"
    const_atomicname[ 32] = "Ge"
    const_atomicname[ 33] = "As"
    const_atomicname[ 34] = "Se"
    const_atomicname[ 35] = "Br"
    const_atomicname[ 36] = "Kr"
    const_atomicname[ 37] = "Rb"
    const_atomicname[ 38] = "Sr"
    const_atomicname[ 39] = "Y" 
    const_atomicname[ 40] = "Zr"
    const_atomicname[ 41] = "Nb"
    const_atomicname[ 42] = "Mo"
    const_atomicname[ 43] = "Tc"
    const_atomicname[ 44] = "Ru"
    const_atomicname[ 45] = "Rh"
    const_atomicname[ 46] = "Pd"
    const_atomicname[ 47] = "Ag"
    const_atomicname[ 48] = "Cd"
    const_atomicname[ 49] = "In"
    const_atomicname[ 50] = "Sn"
    const_atomicname[ 51] = "Sb"
    const_atomicname[ 52] = "Te"
    const_atomicname[ 53] = "I" 
    const_atomicname[ 54] = "Xe"
    const_atomicname[ 55] = "Cs"
    const_atomicname[ 56] = "Ba"
    const_atomicname[ 57] = "La"
    const_atomicname[ 58] = "Ce"
    const_atomicname[ 59] = "Pr"
    const_atomicname[ 60] = "Nd"
    const_atomicname[ 61] = "Pm"
    const_atomicname[ 62] = "Sm"
    const_atomicname[ 63] = "Eu"
    const_atomicname[ 64] = "Gd"
    const_atomicname[ 65] = "Tb"
    const_atomicname[ 66] = "Dy"
    const_atomicname[ 67] = "Ho"
    const_atomicname[ 68] = "Er"
    const_atomicname[ 69] = "Tm"
    const_atomicname[ 70] = "Yb"
    const_atomicname[ 71] = "Lu"
    const_atomicname[ 72] = "Hf"
    const_atomicname[ 73] = "Ta"
    const_atomicname[ 74] = "W" 
    const_atomicname[ 75] = "Re"
    const_atomicname[ 76] = "Os"
    const_atomicname[ 77] = "Ir"
    const_atomicname[ 78] = "Pt"
    const_atomicname[ 79] = "Au"
    const_atomicname[ 80] = "Hg"
    const_atomicname[ 81] = "Tl"
    const_atomicname[ 82] = "Pb"
    const_atomicname[ 83] = "Bi"
    const_atomicname[ 84] = "Po"
    const_atomicname[ 85] = "At"
    const_atomicname[ 86] = "Rn"
    const_atomicname[ 87] = "Fr"
    const_atomicname[ 88] = "Ra"
    const_atomicname[ 89] = "Ac"
    const_atomicname[ 90] = "Th"
    const_atomicname[ 91] = "Pa"
    const_atomicname[ 92] = "U" 
    const_atomicname[ 93] = "Np"
    const_atomicname[ 94] = "Pu"
    const_atomicname[ 95] = "Am"
    const_atomicname[ 96] = "Cm"
    const_atomicname[ 97] = "Bk"
    const_atomicname[ 98] = "Cf"
    const_atomicname[ 99] = "Es"
    const_atomicname[100] = "Fm"
    const_atomicname[101] = "Md"
    const_atomicname[102] = "No"
    const_atomicname[103] = "Lr"
}
{ print const_atomicname[$1+0] }

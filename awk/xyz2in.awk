#! /usr/bin/awk -f

# usage: xyz2in.awk bleh.xyz bleh.scf.in > new.scf.in

BEGIN{
    define_mass()
}
FILENAME==ARGV[1]{
    if (FNR == 1){
	nat = $1 + 0;
	getline;
	for (i=0;i<nat;i++){
	    getline;
	    at[i] = tolower($1)
	    x[i] = $2
	    y[i] = $3
	    z[i] = $4
	    isatom[tolower($1)]++
	}
	for (i in isatom)
	    ntyp++
    }
    next
}
/^ *nat/{
    printf(" nat=%d,\n",nat);
    next
}
/^ *ntyp/{
    printf(" ntyp=%d,\n",ntyp);
    next
}
/^ *ATOMIC_SPECIES/,/^ *$/{
    if ($0 ~ /ATOMIC_SPECIES/){
	print
	for (i in isatom){
	    printf "%-2s %10.5f %2s.UPF\n", i, const_atomicmass[i], i
	}
	print ""
    }
    next
}
/^ *ATOMIC_POSITIONS/,/^ *$/{
    if ($0 ~ /ATOMIC_POSITIONS/){
	print "ATOMIC_POSITIONS angstrom"
	for (i=0;i<nat;i++)
	    printf "%-2s %15.9f %15.9f %15.9f\n", at[i], x[i], y[i], z[i]
	print ""
    }
    next
}
(FILENAME == ARGV[2])

function define_mass(){
    const_atomicmass["h"] = 1.00794
    const_atomicmass["he"] = 4.002602
    const_atomicmass["li"] = 6.941
    const_atomicmass["be"] = 9.012182
    const_atomicmass["b"] = 10.811
    const_atomicmass["c"] = 12.0107
    const_atomicmass["n"] = 14.0067
    const_atomicmass["o"] = 15.9994
    const_atomicmass["f"] = 18.9984032
    const_atomicmass["ne"] = 20.1797
    const_atomicmass["na"] = 22.989770
    const_atomicmass["mg"] = 24.3050
    const_atomicmass["al"] = 26.981538
    const_atomicmass["si"] = 28.0855
    const_atomicmass["p"] = 30.973761
    const_atomicmass["s"] = 32.065
    const_atomicmass["cl"] = 35.453
    const_atomicmass["ar"] = 39.948
    const_atomicmass["k"] = 39.0983
    const_atomicmass["ca"] = 40.078
    const_atomicmass["sc"] = 44.955910
    const_atomicmass["ti"] = 47.867
    const_atomicmass["v"] = 50.9415
    const_atomicmass["cr"] = 51.9961
    const_atomicmass["mn"] = 54.938049
    const_atomicmass["fe"] = 55.845
    const_atomicmass["co"] = 58.933200
    const_atomicmass["ni"] = 58.6934
    const_atomicmass["cu"] = 63.546
    const_atomicmass["zn"] = 65.409
    const_atomicmass["ga"] = 69.723
    const_atomicmass["ge"] = 72.64
    const_atomicmass["as"] = 74.92160
    const_atomicmass["se"] = 78.96
    const_atomicmass["br"] = 79.904
    const_atomicmass["kr"] = 83.798
    const_atomicmass["rb"] = 85.4678
    const_atomicmass["sr"] = 87.62
    const_atomicmass["y"] = 88.90585
    const_atomicmass["zr"] = 91.224
    const_atomicmass["nb"] = 92.90638
    const_atomicmass["mo"] = 95.94
    const_atomicmass["tc"] = 97
    const_atomicmass["ru"] = 101.07
    const_atomicmass["rh"] = 102.90550
    const_atomicmass["pd"] = 106.42
    const_atomicmass["ag"] = 107.8682
    const_atomicmass["cd"] = 112.411
    const_atomicmass["in"] = 114.818
    const_atomicmass["sn"] = 118.710
    const_atomicmass["sb"] = 121.760
    const_atomicmass["te"] = 127.60
    const_atomicmass["i"] = 126.90447
    const_atomicmass["xe"] = 131.293
    const_atomicmass["cs"] = 132.90545
    const_atomicmass["ba"] = 137.327
    const_atomicmass["la"] = 138.9055
    const_atomicmass["ce"] = 140.116
    const_atomicmass["pr"] = 140.90765
    const_atomicmass["nd"] = 144.24
    const_atomicmass["pm"] = 145
    const_atomicmass["sm"] = 150.36
    const_atomicmass["eu"] = 151.964
    const_atomicmass["gd"] = 157.25
    const_atomicmass["tb"] = 158.92534
    const_atomicmass["dy"] = 162.500
    const_atomicmass["ho"] = 164.93032
    const_atomicmass["er"] = 167.259
    const_atomicmass["tm"] = 168.93421
    const_atomicmass["yb"] = 173.04
    const_atomicmass["lu"] = 174.967
    const_atomicmass["hf"] = 178.49
    const_atomicmass["ta"] = 180.9479
    const_atomicmass["w"] = 183.84
    const_atomicmass["re"] = 186.207
    const_atomicmass["os"] = 190.23
    const_atomicmass["ir"] = 192.217
    const_atomicmass["pt"] = 195.078
    const_atomicmass["au"] = 196.96655
    const_atomicmass["hg"] = 200.59
    const_atomicmass["tl"] = 204.3833
    const_atomicmass["pb"] = 207.2
    const_atomicmass["bi"] = 208.98038
    const_atomicmass["po"] = 209
    const_atomicmass["at"] = 210
    const_atomicmass["rn"] = 222
    const_atomicmass["fr"] = 223
    const_atomicmass["ra"] = 226
    const_atomicmass["ac"] = 227
    const_atomicmass["th"] = 232.04
    const_atomicmass["pa"] = 231
    const_atomicmass["u"] = 238.03
    const_atomicmass["np"] = 237
    const_atomicmass["pu"] = 244
    const_atomicmass["am"] = 243
    const_atomicmass["cm"] = 247
    const_atomicmass["bk"] = 247
    const_atomicmass["cf"] = 251
    const_atomicmass["es"] = 254
    const_atomicmass["fm"] = 257
    const_atomicmass["md"] = 258
    const_atomicmass["no"] = 255
    const_atomicmass["lr"] = 260
}

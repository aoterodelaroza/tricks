#! /usr/bin/awk -f

# sumcube.awk a1.cube a2.cube ... 
# Sums the grid function values for an arbitrary number of cube files. 

(FNR == 3) { nat = $1 }
(FNR > 6+nat){
    for (i=1;i<=NF;i++){
	sum += $i
    }
}
END{printf "%.10f\n",sum}

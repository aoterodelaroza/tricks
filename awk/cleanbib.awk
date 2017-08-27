#! /usr/bin/awk -f
# Copyright (C) 2011 A. Otero-de-la-Roza <alberto@carbono.quimica.uniovi.es>
#    and V. Lua~na <victor@carbono.quimica.uniovi.es>. Universidad de Oviedo.
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Use:
# cleanbib.awk file1.bib file2.bib file3.bib
#
# Cleanbib primary purpose is to detect duplicates in several .bib files and
# correct journal names. If a journal name is not registered, modify
# the define_journals() function at the end of the script.
# 
BEGIN{
    define_journals()
}
{cl = $0; $0 = tolower($0)}
/^@article/{
    ns++
    n1 = index(cl,"{"); n2 = index(cl,",")
    key[ns] = substr(cl,n1+1,n2-n1-1)
    sub(/^ */,"",key[ns])
    file[ns] = FILENAME
    fnr[ns] = FNR


    # compare keys.
    if (iskey[key[ns]]){
	printf "WARNING -- duplicate key : %s (%s line %d | %s line %d)\n", key[ns], \
	    file[ns], fnr[ns], file[iskey[key[ns]]], fnr[iskey[key[ns]]]
    }
    else 
	iskey[key[ns]] = ns
    
    # read rest of fields
    nbrak = 1
    while(nbrak > 0){
	getline

	# count braces
	cl = $0
	while (index(cl,"{") != 0){
	    nbrak = nbrak + gsub("{","",cl)
	}
	while (index(cl,"}") != 0){
	    nbrak = nbrak - gsub("}","",cl)
	}
	cl = $0; $0 = tolower($0)

	# journal
	if ($0 ~ /^( |\t)*journal( |\t)*=/){
	    journal[ns] = bibtex_strip($0,"journal")
	    if (!isjournal[journal[ns]]){
		printf "WARNING -- unknown journal : %s (key: %s, file: %s, line %d)\n", journal[ns], \
		    key[ns], file[ns], fnr[ns]
	    
	    }
	    journal[ns] = isjournal[journal[ns]]
	    continue
	}
	
	# volume
	if ($0 ~ /^( |\t)*volume( |\t)*=/){
	    volume[ns] = bibtex_strip($0,"volume")
	    if (volume[ns] != volume[ns]+0){
		printf "WARNING -- non-numeric volume : %s (key: %s, file: %s, line %d)\n", volume[ns], \
		    key[ns], file[ns], fnr[ns]
	    }
	    continue
	}

	# pages
	if ($0 ~ /^( |\t)*pages( |\t)*=/){
	    pages[ns] = bibtex_strip($0,"pages")
	    continue
	}
	# year
	if ($0 ~ /^( |\t)*year( |\t)*=/){
	    year[ns] = bibtex_strip($0,"year")
	    continue
	}
	# status
	if ($0 ~ /^( |\t)*status( |\t)*=/){
 	    status[ns] = bibtex_strip($0,"status")
	    continue
	}
    }
    # check this ref.
    if (!journal[ns])
 	printf "WARNING -- no journal info. (key: %s, file: %s, line %d)\n", key[ns], file[ns], fnr[ns]
    if (!status[ns]){
	if (!volume[ns])
	    printf "WARNING -- no volume info. (key: %s, file: %s, line %d)\n", key[ns], file[ns], fnr[ns]
	if (!pages[ns])
	    printf "WARNING -- no pages info. (key: %s, file: %s, line %d)\n", key[ns], file[ns], fnr[ns]
	if (!year[ns])
	    printf "WARNING -- no year info. (key: %s, file: %s, line %d)\n", key[ns], file[ns], fnr[ns]
	refid[ns] = journal[ns] "_" year[ns] "_" volume[ns] "_" pages[ns] 
    } else {
	refid[ns] = journal[ns] "_" year[ns] "_" status[ns]
    }
    if (isref[refid[ns]]){
	printf "WARNING -- duplicate reference : (key: %s , file: %s , line: %d | key: %s , file: %s , line: %d)\n", key[ns], \
	    file[ns], fnr[ns], key[isref[refid[ns]]], file[isref[refid[ns]]], fnr[isref[refid[ns]]]
    } else {
	isref[refid[ns]] = ns
    }
}
END{
    for (i=1;i<=ns;i++){
	printf "%d. file:%s line:%s key:%s -> %s %s (%s) %s \n", i, file[i], fnr[i], key[i], journal[i], volume[i], year[i], pages[i]
    }
}
# xxxx functions xxxx
function define_journals(){
    isjournal["acc. chem. res."] = "acr"
    isjournal["acta cryst."] = "acrys"
    isjournal["acta cryst. a"] = "acrysa"
    isjournal["acta cryst. b"] = "acrysb"
    isjournal["acta cryst. c"] = "acrysc"
    isjournal["adv. math."] = "advmath"
    isjournal["angew. chem. intl. ed."] = "angew"
    isjournal["angew. chem. int. ed."] = "angew"
    isjournal["appl. phys. lett."] = "apl"
    isjournal["aust. j. chem."] = "austjc"
    isjournal["can. j. phys."] = "cjp"
    isjournal["can. j. chem."] = "cjc"
    isjournal["chem. eur. j."] = "ceurj"
    isjournal["chem. phys. lett."] = "cpl"
    isjournal["chem. phys."] = "cp"
    isjournal["chem. phys. chem."] = "cpc"
    isjournal["chem. phys. phys. chem."] = "cppc"
    isjournal["chem. rev."] = "chemrev"
    isjournal["chem. soc. rev."] = "chemsocrev"
    isjournal["collect. czech. chem. commun."] = "cccczech"
    isjournal["comput. mater. sci."] = "cmatsci"
    isjournal["comput. mol. sci."] = "cms"
    isjournal["comput. phys. commun."] = "cpc"
    isjournal["comput. theor. chem."] = "ctc"
    isjournal["cryst. eng. comm."] = "crystengcomm"
    isjournal["eur. j. miner."] = "ejm"
    isjournal["int. j. mod. phys. b"] = "ijmpb"
    isjournal["int. j. quantum chem. symp."] = "ijqcsymp"
    isjournal["int. j. quantum chem."] = "ijqc"
    isjournal["int. rev. phys. chem."] = "irpc"
    isjournal["j. am. chem. soc."] = "jacs"
    isjournal["j. appl. cryst."] = "jacrys"
    isjournal["j. appl. phys."] = "jap"
    isjournal["j. chem. phys."] = "jcp"
    isjournal["j. chem. theory comput."] = "jctc"
    isjournal["j. chem. thermodyn."] = "jct"
    isjournal["j. comput. chem."] = "jcc"
    isjournal["j. electron. mater."] = "jem"
    isjournal["j. geophys. res."] = "jgr"
    isjournal["j. math. chem."] = "jmathc"
    isjournal["j. mol. struct. (theochem)"] = "jmstheo"
    isjournal["j. org. chem."] = "joc"
    isjournal["j. phys. b"] = "jphysb"
    isjournal["j. phys. b: at. mol. phys."] = "jphysb"
    isjournal["j. phys. c"] = "jphysc"
    isjournal["j. phys. f"] = "jphysf"
    isjournal["j. phys. f: met. phys."] = "jphysf"
    isjournal["j. phys. chem."] = "jpc"
    isjournal["j. phys. chem. a"] = "jpca"
    isjournal["j. phys. chem. b"] = "jpcb"
    isjournal["j. phys. chem. c"] = "jpcc"
    isjournal["j. phys. chem. lett."] = "jpcl"
    isjournal["j. phys. chem. ref. data"] = "jpcrdata"
    isjournal["j. phys. chem. solids"] = "jpcs"
    isjournal["j. phys.-condens. matter"] = "jpcm"
    isjournal["j. phys.: condens. matter"] = "jpcm"
    isjournal["j. phys. math. soc. japan"] = "jpmsj"
    isjournal["j. phys. org. chem."] = "jpoc"
    isjournal["j. phys. soc. jpn."] = "jpsjap"
    isjournal["mol. phys."] = "molphys"
    isjournal["mrs bull."] = "mrsbull"
    isjournal["netsu sokutei"] = "nsokutei"
    isjournal["nature"] = "natur"
    isjournal["nat. mater."] = "naturemat"
    isjournal["org. proc. res. dev."] = "oprd"
    isjournal["org. lett."] = "orglett"
    isjournal["phys. chem. chem. phys."] = "pccp"
    isjournal["phys. chem. miner."] = "pcm"
    isjournal["phys. earth planet. int."] = "pepi"
    isjournal["phys. rev."] = "pr"
    isjournal["phys. rev. a"] = "pra"
    isjournal["phys. rev. b"] = "prb"
    isjournal["phys. rev. e"] = "pre"
    isjournal["phys. rev. lett."] = "prl"
    isjournal["proc. cambridge phil. soc."] = "proccam"
    isjournal["proc. phys. soc. a"] = "procpsa"
    isjournal["proc. natl. acad. sci."] = "pnas"
    isjournal["proc. natl. acad. sci. usa"] = "pnas"
    isjournal["proc. natl. acad. sci. u.s.a."] = "pnas"
    isjournal["psi-k newsletter"] = "psik"
    isjournal["pure appl. chem."] = "pac"
    isjournal["rend. accad. naz. lincei"] = "ranl"
    isjournal["rev. mod. phys."] = "rmp"
    isjournal["rev. sci. instrum."] = "rsi"
    isjournal["science"] = "science"
    isjournal["solid state commun."] = "ssc"
    isjournal["theor. chim. acta"] = "tca"
    isjournal["theor. chem. acc."] = "tcac"
    isjournal["wires comput. mol. sci."] = "wires"
    isjournal["z. kristallogr."] = "zkris"
    isjournal["z. physik"] = "zphys"

    for (i in isjournal){
	isjournal[isjournal[i]] = isjournal[i]
    }
}
function bibtex_strip(s,key){
    sub(/^( |\t)*/,s)
    sub(key,"",s)
    sub(/( |\t)*=( |\t)*({|")*( |\t)*/,"",s)
    sub(/( |\t)*(}|")*( |\t)*,*( |\t|\n)*$/,"",s)
    return s
}

#! /bin/bash

clean_(){
    cat >&3 <<EOM
rm -f stdout IBZKPT CHG EIGENVAL DOSCAR PROCAR PCDAT XDATCAR \\
      LOCPOT PROOUT TMPCAR REPORT vasprun.xml >& /dev/null
rm -f WAVECAR

EOM
}

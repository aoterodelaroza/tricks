#! /bin/bash

clean_(){
    cat >&3 <<EOM
rm -f fort.* 55 DAO DFINT EXIT FOCK iface KEYWD localcc.restart MOCOEF* MOLDEN* OCCUP
rm -f OEINT OSVFILE PRINT SCFDENSITIES* SCHOL SROOT SYMTRA TEDAT TEINT VARS

EOM
}

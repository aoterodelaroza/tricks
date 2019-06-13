#! /bin/bash

clean(){
    cat >&3 <<EOM
rm -r crystal.wfc* crystal*/ _ph0/

EOM
}

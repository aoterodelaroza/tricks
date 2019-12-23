#! /bin/bash

clean_(){
    cat >&3 <<EOM
rm -r crystal.wfc* crystal*/ _ph0/ tmp.pp crystal*xml

EOM
}

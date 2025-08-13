#! /bin/bash

clean_(){
    cat >&3 <<EOM
rm -f band.out charges.bin detailed.out dftb_pin.hsd

EOM
}

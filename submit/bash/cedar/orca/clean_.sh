#! /bin/bash

clean_(){
    cat >&3 <<EOM
rm -f *.tmp* *.txt *.prop

EOM
}

#! /bin/bash

clean_(){
    cat >&3 <<EOM
rm -f core.*

EOM
}

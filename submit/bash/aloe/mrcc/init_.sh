#! /bin/bash

init_(){
    cat >&3 <<EOM
export PATH=/opt/software/mrcc.2020-02-22_binary/:\$PATH
EOM
}

#! /bin/bash

init_(){
    cat >&3 <<EOM
# critic
export CRITIC_HOME=/opt/uovi/alberto/critic2/
export PATH=/opt/uovi/alberto/critic2/bin:\${PATH}

EOM
}

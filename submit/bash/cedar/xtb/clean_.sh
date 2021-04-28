#! /bin/bash

clean_(){
    cat >&3 <<EOM
rm -f charges wbo xtbopt.log xtbrestart xtbtopo.mol

EOM
}

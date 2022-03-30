#! /bin/bash

clean_(){
    cat >&3 <<EOM
rm -f ${i}.*.tmp* ${i}_property.txt ${i}.prop ${i}.gbw

EOM
}

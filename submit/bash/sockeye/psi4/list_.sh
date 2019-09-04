#! /bin/bash

list_(){
    list=$(find . -maxdepth 1 -type f -name '*.inp' -printf '%P\n' | shuf)
    extension=".inp"
    prefix="psi"
}

#! /bin/bash

list_(){
    list=$(find . -maxdepth 1 -type f -name '*.gjf' -printf '%P\n' | shuf)
    extension=".gjf"
    prefix="gau"
}

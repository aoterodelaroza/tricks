#! /bin/bash

list_(){
    list=$(find . -maxdepth 1 -type f -name '*.cri' -printf '%P\n' | shuf)
    extension=".cri"
    prefix="cri"
}

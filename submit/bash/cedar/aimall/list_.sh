#! /bin/bash

list_(){
    list=$(find . -maxdepth 1 -type f -name '*.wfx' -printf '%P\n' | shuf)
    extension=".wfx"
    prefix="aim"
}

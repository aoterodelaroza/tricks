#! /bin/bash

list(){
    list=$(find . -maxdepth 1 -type f -name '*.wfx' -printf '%P\n' | shuf)
    extension=".wfx"
    prefix="aim"
}

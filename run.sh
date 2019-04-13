#!/bin/bash

xhost + # allow connections to X server
sudo docker run --privileged                            \
                -e "DISPLAY=$DISPLAY"                   \
                -v "/tmp/.X11-unix:/tmp/.X11-unix:rw"   \
                -v "`pwd`/$1:/root/go"                  \
                --ipc=host                              \
                -it --rm go_env


#!/bin/bash

ROOT_DIR="$(cd $( dirname ${BASH_SOURCE[0]} ) && pwd)"

shopt -s expand_aliases
source $HOME/.bashrc
source ${ROOT_DIR}/aliases.sh

xdocker rm `docker ps -a -q`
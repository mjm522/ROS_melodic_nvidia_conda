#!/bin/bash

echo Assuming this is a fresh install with no previous versions of docker. If it does exist completely remove them.

read -p "Continue (y/n)?" choice
case "$choice" in 
  y|Y ) echo "Continue with the installation"\
        sh ./setup_docker_nvidia.sh;;
  n|N ) exit 1;;
  * ) echo "invalid";;
esac
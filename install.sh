#!/bin/bash

ROOT_DIR="$(cd $( dirname ${BASH_SOURCE[0]} ) && pwd)"
echo "Root Directory is: ${ROOT_DIR}"

FILE=~/.bashrc
ALIAS="alias rosdocker"
FUNCTION="function newdockterm"
IMAGE_TAG=melodic

exists()
{
  grep -qF "$1" $FILE;
}


./docker_build.sh $IMAGE_TAG


if exists "$ALIAS";then
   echo "alias rosdocker found, skipping..."
else
   ALIAS="${ALIAS}='${ROOT_DIR}/bash.sh dev:melodic-conda'"
   echo "alias not found in ~/.bashrc adding it..."
   echo -e "\n$ALIAS" >> $FILE
fi

if exists "$FUNCTION";then
   echo "function newdockterm found, skipping..."
else
   FUNCTION="${FUNCTION}(){ ${ROOT_DIR}/exec_container.sh \$(${ROOT_DIR}/get_containerId.sh);}"
   echo "function not found in ~/.bashrc adding it..."
   echo -e "\n$FUNCTION" >> $FILE
fi

source ~/.bashrc

./bash.sh dev:$IMAGE_TAG

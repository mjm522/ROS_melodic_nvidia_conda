#!/bin/bash

ROOT_DIR="$(cd $( dirname ${BASH_SOURCE[0]} ) && pwd)"
# echo "Root Directory is: ${ROOT_DIR}"
SCRIPT_DIR="$(dirname "$ROOT_DIR")/scripts"
IMAGE_DIR=$ROOT_DIR

FILE=~/.bashrc
ALIAS="alias rosdocker"
FUNCTION="function newdockterm"
IMAGE_TAG=melodic
DOCKER_USER=mydocker
DOCKER_GID=998
DOCKER_UID=998

exists()
{
  grep -qF "$1" $FILE;
}


/bin/bash ${SCRIPT_DIR}/docker_build.sh $IMAGE_DIR/$IMAGE_TAG  ${DOCKER_USER} ${DOCKER_GID} ${DOCKER_UID}


if exists "$ALIAS";then
   echo "alias rosdocker found, skipping..."
else
   ALIAS="${ALIAS}='${SCRIPT_DIR}/bash.sh dev:melodic-conda'"
   echo "alias not found in ~/.bashrc adding it..."
   echo -e "\n$ALIAS" >> $FILE
fi

if exists "$FUNCTION";then
   echo "function newdockterm found, skipping..."
else
   FUNCTION="${FUNCTION}(){ ${SCRIPT_DIR}/exec_container.sh \$(${SCRIPT_DIR}/get_containerId.sh);}"
   echo "function not found in ~/.bashrc adding it..."
   echo -e "\n$FUNCTION" >> $FILE
fi

source ~/.bashrc

/bin/bash ${SCRIPT_DIR}/bash.sh dev:$IMAGE_TAG

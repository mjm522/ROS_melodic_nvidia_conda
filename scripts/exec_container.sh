#!/bin/bash

ROOT_DIR="$(cd $( dirname ${BASH_SOURCE[0]} ) && pwd)"

if [ $# -ne 1 ]; then
	echo "usage: ./exec_container.sh <container_id>"
    echo "example: ./docker_build.sh fa11998579c"
    echo "to get current container id, run ./get_containerId.sh script"
  exit 1
fi

echo 'Entering container:' $1
docker exec -it $1 bash
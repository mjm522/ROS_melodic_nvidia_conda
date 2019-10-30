#!/bin/bash

# Description: starts container and opens an interactive bash shell using image tag passed as parameter
# Usage: ./bash.sh <docker-image-tag>
# Example: ./bash.sh dev:melodic
sudo usermod -aG audio $USER

DOCKER_IMAGE=$1
WORK_DIR="${HOME}/Projects/"


if [ -z "$DOCKER_IMAGE" ]
then
      echo "usage: ./bash.sh <docker-image-tag>"
      echo "example: ./bash.sh dev:melodic"
      echo "to list built docker images run: docker images"
      exit 1
fi


XAUTH=/tmp/.docker.xauth
if [ ! -f $XAUTH ]
then
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi

docker run -it \
    --privileged\
    --env="DISPLAY=$DISPLAY" \
    --env="PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="XAUTHORITY=$XAUTH" \
    --group-add="$(getent group audio | cut -d: -f3)"\
    --device="/dev/snd" \
    --network="host" \
    --privileged \
    --volume="${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$XAUTH:$XAUTH" \
    --volume="/dev:/dev"\
    --workdir="$WORK_DIR" \
    --runtime=nvidia \
    $DOCKER_IMAGE \
    bash
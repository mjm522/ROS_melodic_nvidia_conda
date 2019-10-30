#!/bin/bash

DOCKER_FILE_PATH=$1
DOCKER_USER=$2
DOCKER_GID=$3
DOCKER_UID=$4

docker build ${DOCKER_FILE_PATH} --build-arg DOCKER_USER=$DOCKER_USER \
                                 --build-arg DOCKER_GID=${DOCKER_GID} \
                                 --build-arg DOCKER_UID=${DOCKER_UID} \
                                 --tag dev:${DOCKER_FILE_PATH##*/}
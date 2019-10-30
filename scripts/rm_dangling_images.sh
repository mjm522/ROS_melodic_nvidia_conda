#!/bin/bash

if [ "$(docker images -f "dangling=true" -q | awk '{print $3}' | sort -u)x" != "x" ]
then
       docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
fi
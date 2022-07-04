#!/bin/bash

backup_name=$(basename "$1")
volume_name=$(echo "$backup_name" | sed -n 's/\(.*\)\(-[[:digit:]]*\)\{6\}/\1/p')

result=$(docker volume ls -q | grep -c ^"$volume_name"$)
if [ "$result" -gt 0 ]; then
    echo "volume $volume_name had exist"
    exit 1
fi

docker run --rm  \
    --volume "$volume_name":/dbdata \
    --volume "$(pwd)"/backup:/backup \
    ubuntu \
    tar xvf /backup/"$backup_name" -C /dbdata --strip 1

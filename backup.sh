#!/bin/bash

mkdir -p backup

DATE=$(date +%Y-%m-%d-%H-%M-%S)
volume_name=$1
backup_name=$volume_name-$DATE

result=$(docker volume ls -q | grep -c ^"$volume_name"$)
if [ "$result" -eq 0 ]; then
    echo "volume $volume_name doesn't exist"
    exit 1
fi

docker run --rm \
    --volume "$volume_name":/dbdata \
    --volume "$(pwd)"/backup:/backup \
    ubuntu \
    tar cvf /backup/"$backup_name" /dbdata

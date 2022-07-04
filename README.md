# backup and restore volume

[ref_link](https://docs.docker.com/storage/volumes/#backup-restore-or-migrate-data-volumes)

## backup

backup a named volume to `backup` direcotry in current path, with the date message append to its name, the volume should be list in `docker volume ls`

usage:

`./backup.sh named_volume`

backup a multi volume by usual way like:

`docker volume ls -q | grep some_key_word | xargs -i ./backup.sh {}`


## restore

restore a volume from `backup` direcotry in current path, the restored volume's name would withdraw the date message, contrary to backup, the name should not be list in `docker volume ls` (just prevent mistake)

usage:

`./restore.sh backup/volume_to_restore-yyyy-mm-dd-hh-mm-ss`

restore multi volume:

`ls backup/ | grep some_key_word | xargs -i ./restore.sh {}`

## notice



If start containers with `docker-compose.yaml`, maybe come with warning **xxx already exists but was not created by Docker Compose. Use \`external: true\`** after restored, I would sign the volumes with `external: true`, and create it at the first time.

```
# creat volume
docker volume create xxx_volume`
```

```
# docker-compose.yaml

volumes:
  xxx_volume:
    name: xxx_volume
    external: true
```

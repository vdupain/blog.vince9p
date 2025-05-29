#!/bin/sh

USER=user
HOST=haiku.home
DIR=/var/www/htdocs/

hugo --config hugo-haiku.toml
cp static/haiku.png public/avatar.jpg
rsync -avz --chown="user:root" --delete public/ ${USER}@${HOST}:${DIR}
rsync -avz --chown="user:root" --delete scripts ${USER}@${HOST}:/boot/home
ssh ${USER}@${HOST} "/boot/home/scripts/generate-status-haiku.sh"

exit 0
#!/bin/sh

USER=root
HOST=beagle.home
DIR=/var/www/htdocs/

hugo --config hugo-beagle.toml
cp public/posts/my-homelab/images/beaglebone-black.png public/avatar.jpg
rsync -avz --chown="root:daemon" --delete public/ ${USER}@${HOST}:${DIR}
rsync -avz --chown="root:wheel" --delete scripts ${USER}@${HOST}:/${USER}/
#ssh ${USER}@${HOST} "/${USER}/scripts/generate-status.sh"

exit 0
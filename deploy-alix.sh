#!/bin/sh

USER=root
HOST=alix.home
DIR=/var/www/htdocs/

hugo --config hugo-alix.toml
cp public/posts/my-homelab/images/alix2d3.png public/avatar.jpg
rsync -avz --chown="root:daemon" --delete public/ ${USER}@${HOST}:${DIR}
rsync -avz --chown="root:wheel" --delete scripts-alix ${USER}@${HOST}:/${USER}/
ssh ${USER}@${HOST} /${USER}/scripts-alix/generate-status.sh

exit 0
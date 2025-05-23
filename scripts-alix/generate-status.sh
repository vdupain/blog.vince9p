#!/usr/bin/env sh

echo "Generating status page..."
scriptdir=$(dirname $0)
mkdir -p /var/www/htdocs/status
echo "<!doctype html>" > /var/www/htdocs/status/index.html
echo "<html><head></head><body><pre>" >> /var/www/htdocs/status/index.html
$scriptdir/status.sh >> /var/www/htdocs/status/index.html
echo "</pre></body></html>" >> /var/www/htdocs/status/index.html
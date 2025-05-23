#!/usr/bin/env sh
scriptdir=$(dirname $0)
echo "\n============================================================================="
echo "PC Engines ALIX 2d3 Status (generated at: $(date))"
echo "============================================================================="
echo "\n===== bsdfetch ====="
$scriptdir/bsdfetch.sh
echo "\n===== uptime ====="
uptime
echo "\n===== uname -a ====="
uname -a
echo "\n===== vmstat ====="
vmstat
echo "\n===== iostat ====="
iostat
echo "\n===== df -h /====="
df -h /
echo "\n===== top ====="
top -bn1
echo "\n===== dmesg ====="
dmesg
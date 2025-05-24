#!/usr/bin/env sh
scriptdir=$(dirname $0)
echo "============================================================================="
echo "Status Page (generated at: $(date))"
echo "============================================================================="
echo ""
echo "===== bsdfetch ====="
$scriptdir/bsdfetch.sh
echo ""
echo "===== uptime ====="
uptime
echo ""
echo "===== uname -a ====="
uname -a
echo ""
echo "===== vmstat ====="
vmstat
echo ""
echo "===== iostat ====="
iostat
echo ""
echo "===== df -h ====="
df -h
echo ""
echo "===== top ====="
top -bn1
echo ""
echo "===== dmesg ====="
dmesg
#!/usr/bin/env sh
scriptdir=$(dirname $0)
echo "============================================================================="
echo "Status Page (generated at: $(date))"
echo "============================================================================="
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
echo "===== df -h ====="
df -h
echo ""
#echo "===== kernel messages ====="
#cat /boot/system/var/log/syslog | grep '^KERN:'
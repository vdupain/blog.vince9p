#!/usr/bin/env sh
# https://github.com/rilysh/bsdfetsh

LC_ALL=C
LANG=C

main() {
	os=$(uname -s)
	release=$(uname -r)
	version="$os $release"
	# On FreeBSD you can also use /etc/rc.conf'
	host=$(uname -n)
	arch=$(uname -m)
	shell=$(ps -p $$ -ocomm=)
	user=$(id -un)
	case $os in
		Free*|Midnight*|Dragon*)
			boot_time=$(sysctl -n kern.boottime | sed -E 's/.* sec = ([[:digit:]]+).*/\1/')
		;;
		Open*|Net*)
			boot_time=$(sysctl -n kern.boottime)
		;;
		*)
			boot_time=0
		;;
	esac
	now_time=$(date +%s)
	sec=$((now_time - boot_time))
	days="$((sec / 60 / 60 / 24))d"
	hours="$((sec / 60 / 60 % 24))h"
	minutes="$((sec / 60 % 60))m"
	uptime="$days $hours $minutes"
	case $os in
		Free*|DragonFly*)
			pkgs=$(pkg info -q | wc -l | sed "s/[[:space:]]//g")
		;;
		Midnight*)
			pkgs=$(mport list | wc -l | sed "s/[[:space:]]//g")
		;;
		Open*|Net*)
			pkgs=$(pkg_info | wc -l | sed "s/[[:space:]]//g")
		;;
		*)
			pkgs=0 # We aren't quite sure what BSD system is that
		;;
	esac
	case $os in
		Free*|Midnight*)
			ctl_mem=$(sysctl -n hw.realmem)
		;;
		Open*|DragonFly*|Net*)
			ctl_mem=$(sysctl -n hw.physmem)
		;;
		*)
			ctl_mem=0
		;;
	esac
	mem=$((ctl_mem / 1048576))
	loadavg=$(uptime | cut -d 'l' -f2 | sed -E "s/oad average|:|s://g;s/ //")
	# You can also use grep boot log in FreeBSD.
	cpu=$(sysctl -n hw.model)
	cores=$(sysctl -n hw.ncpu)
	echo -n "OS : $os
Release: $release
Version: $version
Host: $host
Arch: $arch
Shell: $shell
User: $user
Packages: $pkgs
Uptime: $uptime
RAM: $mem
Loadavg: $loadavg
CPU: $cpu
Cores: $cores
"
}

main
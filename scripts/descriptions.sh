#!/bin/bash
# show packages desciption
[[ "${HTTP_USER_AGENT:0:6}" != 'pacman' ]] && exit 2
declare -r max="${1:-5}"
declare -a packages=($(cat -))

if ((${#packages[@]} <= $max)); then
	for package in "${packages[@]}"; do
	   LANG=C yaourt -Si "${package}" | awk -F':' '/^Desc/ {print "'${package}': "$2}'
	done
fi


#!/bin/bash
# auto restart service if running 
[[ "${HTTP_USER_AGENT:0:6}" != 'pacman' ]] && exit 2
first=1
while read -r service; do
    service=${service##*\/}
    if [[ $(systemctl show "${service}" 2>/dev/null | grep SubState) =~ "running" ]]; then
        if (( first )); then
            systemctl daemon-reload
            unset first
        fi
        systemctl restart "${service}" && echo "${service} re-started"
    fi
done

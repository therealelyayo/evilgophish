#!/bin/bash

evilginx3_cstring=""
for esub in $EVILGINX3_SUBS; do
    evilginx3_cstring+="${esub}.${ROOT_DOMAIN} "
done

if [[ "${E_ROOT_BOOL}" == "true" ]]; then
    evilginx3_cstring+="${ROOT_DOMAIN}"
fi

apache_ip=$(getent hosts apache | awk '{print $1}')
echo "${apache_ip} ${evilginx3_cstring}${ROOT_DOMAIN}" >> /etc/hosts

$@

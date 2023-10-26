#!/bin/bash

gophish_ip=$(getent hosts gophish | awk '{print $1}')
sed -i "s|127.0.0.1|${gophish_ip}|g" /app/gophish/config.json

$@

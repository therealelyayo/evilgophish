#!/bin/bash

if [ "$#" -ne 7 ]; then
  echo "Usage: $0 <root_domain> <evilginx3_subs> <e_root_bool> <redirect_url> <feed_bool> <rid_replacement> <bl_bool>"
  exit 1
fi

# Assign variables based on arguments
ROOT_DOMAIN=$1
EVILGINX3_SUBS=$2
E_ROOT_BOOL=$3
REDIRECT_URL=$4
FEED_BOOL=$5
RID_REPLACEMENT=$6
BL_BOOL=$7

# Function to replace environment variables in docker-compose.yml
replace_env() {
  sed -i "s|${2}:.*|${2}: ${1}|g" docker-compose.yml
}

# Replace values in docker-compose.yml
replace_env "${ROOT_DOMAIN}" "ROOT_DOMAIN"
replace_env "${EVILGINX3_SUBS}" "EVILGINX3_SUBS"
replace_env "${E_ROOT_BOOL}" "E_ROOT_BOOL"
replace_env "${REDIRECT_URL}" "REDIRECT_URL"
replace_env "${FEED_BOOL}" "FEED_BOOL"
replace_env "${RID_REPLACEMENT}" "RID_REPLACEMENT"
replace_env "${BL_BOOL}" "BL_BOOL"

# Build Docker images 
docker compose build 

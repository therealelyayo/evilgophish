#!/bin/bash

if [[ "${FEED_BOOL}" == "true" ]]; then
    sed -i "s|\"feed_enabled\": false,|\"feed_enabled\": true,|g" /app/gophish/config.json
    cd /app/evilfeed
    go build
fi

find /app/gophish -type f -exec sed -i "s|client_id|${RID_REPLACEMENT}|g" {} \;
cd /app/gophish
go build -o gophish

#!/bin/bash

set -o errexit
set -o pipefail
set -x

FULLURL="https://ivendi.grafana.net"
headers="Authorization: Bearer glsa_U5X9q898PtknWDHvGxuE0mtyT2Wn08Qr_eb06a1b9"
in_path="./dashboard/"
set -o nounset

echo "Exporting Grafana dashboards from $FULLURL"
mkdir -p $in_path
cd $in_path
for dash in $(curl -H "$headers" -s "$FULLURL/api/search?query=&" | jq -r '.[] | select(.type == "dash-db") | .uid'); do
    dash_data=$(curl -H "$headers" "$FULLURL/api/dashboards/uid/$dash" )
    slug=$(printf '%s' $dash_data | jq -r '.meta.slug')
    folder="$(printf '%s' $dash_data | jq -r '.meta.folderTitle')"
    mkdir -p "$folder"
    printf '%s' $dash_data | jq -r . > $folder/${dash}-${slug}.json
done
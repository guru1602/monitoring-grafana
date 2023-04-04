#!/bin/sh

headers="Authorization: Bearer <key>"
FULLURL="https://ivendi.grafana.net"
ALERTS="api/v1/provisioning/alert-rules"
CONTACT="api/v1/provisioning/contact-points"
NOTIFICATION="api/v1/provisioning/policies"
TEMPLATES="api/v1/provisioning/templates"
in_path="./alerts"
file="notification.json"

mkdir -p $in_path
cd $in_path

curl -X GET -H "$headers" -H "Content-type: application/json" 'https://ivendi.grafana.net/api/v1/provisioning/policies' | jq > $file

# ALERTS_JSON_PATH=./alerts/
# NUMBER_OF_ALERTS=$(jq -c '.["folder-name"] | length' ${ALERTS_JSON_PATH})

# for ((i=0; i<NUMBER_OF_ALERTS; i++)); do
#   ALERT_OBJECT=$(jq -c --arg i "$i" '.["folder-name"][($i | tonumber)] | del(.rules[0].grafana_alert.uid)' ${ALERTS_JSON_PATH})
#   ALERT_NAME=$(jq -c --arg i "$i" '.["folder-name"][($i | tonumber)].name' ${ALERTS_JSON_PATH})
#   echo "Creating ${ALERT_NAME}...\n"
# 	curl -X POST \
# 		-H "Authorization: Bearer ${GRAFANA_TOKEN}" \
# 		-H "Content-type: application/json" \
# 		'https://example.com/api/ruler/grafana/api/v1/rules/folder-name' \
# 		-d "${ALERT_OBJECT}"
# 	echo "\n"
# done

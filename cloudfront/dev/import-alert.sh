#!/bin/sh

curl -X GET -H "Authorization: Bearer glsa_x8WuTStCSCwk0AeapXRWQcEoDsCQmLO4_6c2f8028" -H "Content-type: application/json" 'https://ivendi.grafana.net/api/ruler/grafana/api/v1/rules' | jq > alerts.json


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
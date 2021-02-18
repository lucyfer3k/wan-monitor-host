#!/bin/bash
#Perform speedtest to nearest server & send them to InfluxDB

echo "speedmon - $(date)"
set -eo pipefail

. ./.env

sleep 10

echo $(speedtest-cli --csv) > ./speedtest_last_result.csv

Download=$(cat ./speedtest_last_result.csv | cut -d ',' -f7)
Upload=$(cat ./speedtest_last_result.csv | cut -d ',' -f8)


curl -s --request POST "http://localhost:8081/api/v2/write?org=$INFLUXDB_ORG&bucket=$INFLUXDB_BUCKET" \
  --header "Content-Type: application/json" \
  --header "Authorization: Token $INFLUXDB_TOKEN" \
  --data-binary "speedtest,host=worker download=$Download,upload=$Upload $(date +%s%N)"

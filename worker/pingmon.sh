#!/bin/bash
#Check well-known DNS latency $ send them to InfluxDB
echo "pingmon - $(date)"

. ./.env

curl -s --request POST "http://localhost:8081/api/v2/write?org=$INFLUXDB_ORG&bucket=$INFLUXDB_BUCKET" \
  --header "Authorization: Token $INFLUXDB_TOKEN" \
  --data-binary "ping,dest=$DNS_NAME_1 $(ping -c 1 $DNS_IP_1 | \
  awk '/time=/{print $7}' | sed -e 's/time/rtt/g') $(date +%s%N)"

curl -s --request POST "http://localhost:8081/api/v2/write?org=$INFLUXDB_ORG&bucket=$INFLUXDB_BUCKET" \
  --header "Authorization: Token $INFLUXDB_TOKEN" \
  --data-binary "ping,dest=$DNS_NAME_2 $(ping -c 1 $DNS_IP_2 | \
  awk '/time=/{print $7}' | sed -e 's/time/rtt/g') $(date +%s%N)"

curl -s --request POST "http://localhost:8081/api/v2/write?org=$INFLUXDB_ORG&bucket=$INFLUXDB_BUCKET" \
  --header "Authorization: Token $INFLUXDB_TOKEN" \
  --data-binary "ping,dest=$DNS_NAME_3 $(ping -c 1 $DNS_IP_3 | \
  awk '/time=/{print $7}' | sed -e 's/time/rtt/g') $(date +%s%N)"

#!/bin/bash

# Establishes environmental variables for the project, overwrites current .env files, appends cron jobs with 

# Check if config file exists and can be called
if [ -e ./config.ini ]; then
  
  #Load user config
  
  . ./config.ini
  
  echo -e "Your environment variables values:\n"
  
  # InfluxDB + Worker
  
  echo "INFLUXDB_TOKEN=$in_token" | tee ./.env
  echo "INFLUXDB_ORG=$in_org" | tee -a ./.env
  echo "INFLUXDB_BUCKET=$in_bucket" | tee -a ./.env
  echo "INFLUXDB_USERNAME=$in_username" | tee -a ./.env
  echo "INFLUXDB_PASSWORD=$in_password" | tee -a ./.env

  # Grafana

  echo "GF_SECURITY_ADMIN_USER=$gr_username" | tee -a ./.env
  echo "GF_SECURITY_ADMIN_PASSWORD=$gr_password" | tee -a ./.env

  # Pingmon

  echo "DNS_NAME_1=$pm_dns_name_1" | tee -a ./.env
  echo "DNS_IP_1=$pm_dns_ip_1" | tee -a ./.env
  echo "DNS_NAME_2=$pm_dns_name_2" | tee -a ./.env
  echo "DNS_IP_2=$pm_dns_ip_2" | tee -a ./.env
  echo "DNS_NAME_3=$pm_dns_name_3" | tee -a ./.env
  echo "DNS_IP_3=$pm_dns_ip_3" | tee -a ./.env

  # Make Grafana setup, Pingmon & Speedmon runnable

  chmod +x ./setup-grafana.sh ./worker/pingmon.sh ./worker/speedmon.sh

  # crontab
  echo -e "\n"
  
  read -p "Append cronfile with speedtest-monitoring every hour and dns servers latency monitoring every minute? (y/n): " cron_append
  if [[ $cron_append == y ]] ; then 
    (crontab -l ; echo "0 * * * * . `pwd`/.env `pwd`/worker/speedmon.sh")| crontab -
    (crontab -l ; echo "* * * * * . `pwd`/.env `pwd`/worker/pingmon.sh")| crontab -
  fi

else
  echo "Config file does not exist"
fi



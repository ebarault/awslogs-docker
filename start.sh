#!/bin/bash
service awslogs stop

# configure aws region for awslogs
sed -i \
  -e "s/region =.*/region = $AWSLOGS_REGION/g" \
  /etc/awslogs/awscli.conf

service awslogs start
service crond start

function ctrl_c() {
  echo "Detected ctrl-c, exiting!"
  exit
}

trap ctrl_c INT

STATUS_AWSLOGS="unknown"
STATUS_CROND="unknown"

# check awslogs and crond service status every minute
until [ -z "$STATUS_AWSLOGS" ] || [ -z "$STATUS_CROND" ]; do
  sleep 60

  STATUS_AWSLOGS="$(service awslogs status)"
  echo $STATUS_AWSLOGS
  STATUS_AWSLOGS=`echo $STATUS_AWSLOGS | grep running`

  STATUS_CROND="$(service crond status)"
  echo $STATUS_CROND
  STATUS_CROND=`echo $STATUS_CROND | grep running`
done

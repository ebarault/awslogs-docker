#!/bin/bash
service awslogs stop

sed -i \
  -e "s/region =.*/region = $AWSLOGS_REGION/g" \
  /etc/awslogs/awscli.conf

service awslogs start

function ctrl_c() {
  echo "Detected ctrl-c, exiting!"
  exit
}

trap ctrl_c INT

STATUS="unknown"
until [ -z "$STATUS" ]; do
  sleep 60
  STATUS="$(service awslogs status)"
  echo $STATUS
  STATUS=`echo $STATUS | grep running`
done

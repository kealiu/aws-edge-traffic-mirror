#!/bin/bash


ENIINFO=$1

echo -n "${ENIINFO},"
EC2ID=$(echo ${ENIINFO}|cut -d "," -f3)
aws ec2 describe-tags --filters Name=key,Values=Name Name=resource-id,Values=${EC2ID} | jq -r ".Tags[].Value"

#!/bin/bash

EC2ID=$1

echo -n "${EC2ID} "
aws ec2 describe-tags --filters Name=key,Values=Name Name=resource-id,Values=${EC2ID} | jq -r ".Tags[].Value"

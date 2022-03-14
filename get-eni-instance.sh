#!/bin/bash

ENIID=$1

echo -n "${ENIID} "
aws ec2 describe-network-interfaces --network-interface-ids ${ENIID} | jq -r '.NetworkInterfaces[] | .PrivateIpAddresses[].PrivateIpAddress + " " + .Attachment.InstanceId'

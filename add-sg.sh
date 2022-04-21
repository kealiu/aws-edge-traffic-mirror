#!/bin/bash 

#
# usage: ./add-sg.sh sg-123456789012
#
# if `sg-123456789012` is not in the same VPC of EC2, error will raised, you can just ignore it.
#

NEWSG=$1

instances=$(aws ec2 describe-instances | jq -r '.Reservations[] | .Instances[] | {"id": .InstanceId, "sg": [.SecurityGroups[].GroupId]|join("&")}' | jq -r '.id+","+.sg')

for ins in ${instances}
do
  echo ${ins}
  insid=$(echo ${ins}|cut -d',' -f1)    
  insg=$(echo ${ins}|cut -d',' -f2| tr '&' ' ')
  aws ec2 modify-instance-attribute --instance-id ${insid} --groups ${insg} ${NEWSG}
done

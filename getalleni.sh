#!/bin/bash

# for alb/nlb

targetids=$(aws elbv2 describe-target-groups | jq '.TargetGroups[].TargetGroupArn' | xargs -n 1 aws elbv2 describe-target-health --target-group-arn  | jq -r '.TargetHealthDescriptions[].Target.Id')
for targetid in ${targetids}
do
    if [[ ${targetid} == i* ]]
    then
        # get eni from instances
        aws ec2 describe-instances --instance-ids ${targetid} | jq -r '.Reservations[].Instances[].NetworkInterfaces[].NetworkInterfaceId'
    else
        # get eni from private-ip
        aws ec2 describe-network-interfaces --filters Name=private-ip-address,Values=${targetid} | jq -r '.NetworkInterfaces[].NetworkInterfaceId'
    fi
done

# for EIP
aws ec2 describe-addresses | jq -r '.Addresses[].NetworkInterfaceId'

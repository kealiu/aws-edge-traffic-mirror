#!/bin/bash -x

# for ELB

## alb/nlb

for lb in $(aws elbv2 describe-load-balancers | jq -r '.LoadBalancers[] | select(.Scheme=="internet-facing") | .LoadBalancerArn')
do
  targetids=$(aws elbv2 describe-target-groups --load-balancer-arn ${lb} | jq '.TargetGroups[].TargetGroupArn' | xargs -n 1 aws elbv2 describe-target-health --target-group-arn  | jq -r '.TargetHealthDescriptions[].Target.Id')
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
done

## clb
for clbec2 in $(aws elb describe-load-balancers | jq -r '.LoadBalancerDescriptions[] | select(.Scheme=="internet-facing") | .Instances[].InstanceId')
do
  aws ec2 describe-instances --instance-ids ${clbec2} | jq -r '.Reservations[].Instances[].NetworkInterfaces[].NetworkInterfaceId'
done


# for EIP
aws ec2 describe-addresses | jq -r '.Addresses[] | select (.InstanceId) | .NetworkInterfaceId'

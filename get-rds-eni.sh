#!/bin/bash

aws ec2 describe-network-interfaces | jq -r '.NetworkInterfaces[] | select(.Description=="RDSNetworkInterface") | .NetworkInterfaceId' 

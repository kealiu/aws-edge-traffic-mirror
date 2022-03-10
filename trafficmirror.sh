#!/bin/bash

TARGETID=$1
FILTERID=$2
SOURCEENI=$3

aws ec2 create-traffic-mirror-session --traffic-mirror-target-id ${TARGETID} --traffic-mirror-filter-id ${FILTERID} --network-interface-id ${SOURCEENI}

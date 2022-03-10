# Overview

get all the ENI of alb/nlb targets & EIP, then add it to traffic mirror session

## Dependences

1. [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
1. [jq](https://stedolan.github.io/jq/)
1. [xargs](https://man7.org/linux/man-pages/man1/xargs.1.html)
1. configure `aws` cli with AWS AK/SK, default region, and output as `json`

# Usage

make sure all `.sh` file executable, by `chmod +x getalleni.sh trafficmirror.sh`

## get all ENI

```
./getalleni.sh
```

## add new traffic mirror session

```
./trafficmirror.sh <traffic-mirror-target-id> <traffic-mirror-filter-id> <source-eni-id>
```

## all in one
```
getalleni.sh  | sort | uniq | xargs -n 1 trafficmirror.sh <traffic-mirror-target-id> <traffic-mirror-filter-id>
```

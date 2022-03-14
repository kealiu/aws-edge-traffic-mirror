# Overview

get all the ENI of alb/nlb targets & EIP, then add it to traffic mirror session
- `get-edge-eni.sh` : get all edge ENI
- `traffic-mirror.sh` : add ENI to traffic mirror session
- `get-eni-instance.sh` : get ENI ip & instances information
- `get-instance-name.sh` : get EC2 instance `Name` tag value

## Dependences

1. [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
1. [jq](https://stedolan.github.io/jq/)
1. [xargs](https://man7.org/linux/man-pages/man1/xargs.1.html)
1. configure `aws` cli with AWS AK/SK, default region, and output as `json`

# Usage

make sure all `.sh` file executable, by `chmod +x *.sh`

### simple find all ENI, and then add it to traffic mirror

```bash
# get ENI id
./get-edge-eni.sh | sort | uniq

# get ENI ip & instance id
./get-edge-eni.sh | sort | uniq | xargs -n 1 ./get-eni-instance.sh 

# get EC2 instance `NAME` tag
./get-edge-eni.sh | sort | uniq | xargs -n 1 ./get-eni-instance.sh |  xargs -n 1 ./get-instance-name.sh

# save to `list.csv`(can open in excel) 
./get-edge-eni.sh | sort | uniq | xargs -n 1 ./get-eni-instance.sh |  xargs -n 1 ./get-instance-name.sh | tee list.csv
```

## only get all ENI

```
./traffic-mirror.sh <traffic-mirror-target-id> <traffic-mirror-filter-id> <source-eni-id>
```

## all all ENI to traffic mirror in one
```
./get-edge-eni.sh  | sort | uniq | xargs -n 1 ./traffic-mirror.sh <traffic-mirror-target-id> <traffic-mirror-filter-id>
```


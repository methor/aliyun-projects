# Aliyun Ping (Aliping) Project

## Goal
We aim to collect raw data about network delays among Aliyun ECSes intra-/inter-districts.

## Description
We conduct the experiment on [9 Aliyun ECSes](https://github.com/hengxin/aliyun-projects/blob/master/aliyun-ecs/aliyun-hosts) 
by letting them keep [*ping*](https://en.wikipedia.org/wiki/Ping_(networking_utility)) each other, once per second.

## Setup

### Copy [`aliping`](https://github.com/hengxin/aliyun-projects/blob/master/aliyun-scripts/aliping) to remote hosts 
1. `alish -l='cat /usr/local/bin/aliping' -r='cat > /usr/local/bin/aliping'`
2. `alish -r='chmod u+x /usr/local/bin/aliping'`

## Run

### Individually
- `aliping`: ping all other ECS hosts

### In batch
- `alish -r='aliping'`

***Note:*** The experiment starts at 16:00 on Sunday, July 03, 2016.

## Setup & Run: Allinone
`alish -l='cat /usr/local/bin/aliping' -r='cat > /usr/local/bin/aliping && chmod u+x /usr/local/bin/aliping && aliping'`

## Stop

### Individually
Copy [aliping-int](https://github.com/hengxin/aliyun-projects/blob/master/aliyun-scripts/aliping-int) to remote hosts
1. `alish -l='/usr/local/bin/aliping-int' -r='/usr/local/bin/aliping-int'`
2. `alish -r='chmod u+x /usr/local/bin/aliping-int'`

Run `sudo aliping-int`.

### In batch
`alish -r='aliping-int'`

### Collect


## Cleanup
1. Remove logs
 - `alish -r='rm -rf /usr/local/bin/aliping-logs/'`

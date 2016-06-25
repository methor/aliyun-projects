# Configurations of Aliyun ECS

## Network

### Change `hostname`
- configure `/etc/hostname` 
- configure `/etc/hosts`

### Appending [`aliyun-host`]() to `/etc/hosts`

Using the [`alish`](https://github.com/hengxin/aliyun-projects/blob/master/aliyun-scripts/alish) script: `alish -l='cat aliyun-host' -r='cat >> /etc/hosts'`

## Software

### [Install Docker](https://github.com/hengxin/cheat-sheets/tree/master/docker-cheat-sheets)
- `wget -qO- https://get.docker.com/ | sh`: Install Docker
- *already on*: `sc2 nc1 nc2 nc3`

### Cassandra in Docker
- `docker pull cassandra`
- *already on*: `sc2 nc1`

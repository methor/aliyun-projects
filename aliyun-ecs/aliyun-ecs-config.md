# Configurations of Aliyun ECS

## Network

### Change `hostname`
- configure `/etc/hostname` 
- configure `/etc/hosts`

### Appending [`aliyun-host`](https://github.com/hengxin/aliyun-projects/blob/master/aliyun-ecs/aliyun-hosts) to `/etc/hosts`

Thus ECSes can communicate with each other by host names instead of ips.

Using the [`alish`](https://github.com/hengxin/aliyun-projects/blob/master/aliyun-scripts/alish) script: `alish -l='cat aliyun-host' -r='cat >> /etc/hosts'`

- [x] already on `nc1 nc2 nc3 ec1 ec2 ec3 sc1 sc2 sc3`

## Software

## [Install JDK8-Oracle](http://www.webupd8.org/2012/09/install-oracle-java-8-in-ubuntu-via-ppa.html)

Using the [`alish`](https://github.com/hengxin/aliyun-projects/blob/master/aliyun-scripts/alish) and the [`jdkinstaller.sh`]() scripts:
`alish -l='cat /usr/local/bin/jdkinstall.sh' -r='cat >> /usr/local/bin/jdkinstall.sh'` and then
`alish -r='jdkinstaller.sh'`
- [x] already on `nc1 nc2 nc3 ec1 ec2 ec3 sc1 sc2 sc3`

### [Install Docker](https://github.com/hengxin/cheat-sheets/tree/master/docker-cheat-sheets)
- `wget -qO- https://get.docker.com/ | sh`: Install Docker on a specific ECS locally
- `curl -sSL https://get.daocloud.io/docker | sh`: Install Docker via [`daocloud`](https://dashboard.daocloud.io/) (which seems faster)
- `alish -r='wget -qO- https://get.docker.com/ | sh'`: Install Docker on all ECSes remotely
- `service docker status`: Check whether Docker has been installed successfully (expected: `docker start/running, process <id>`)

- [x] already on `nc1 nc2 nc3 ec1 ec2 ec3 sc1 sc2 sc3`

### Cassandra in Docker
- `docker pull cassandra`: Install Cassandra with docker locally
- `alish -r='docker pull cassandra'`: Install Cassandra with docker on all ECSes remotely
- [x] already on `nc1 nc2 nc3 ec1 ec2 ec3 sc1 sc2 sc3`

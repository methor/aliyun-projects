#!/bin/bash - 
#===============================================================================
#
#          FILE: aliccd.sh
# 
#         USAGE: ./aliccd.sh 
# 
#   DESCRIPTION: aliccd means aliyun-cassandra-cluster-(with)-docker
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Hengfeng Wei (hengxin) 
#  ORGANIZATION: ICS, NJU
#       CREATED: July 14, 2016, 21:55
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

function usage() {
    echo "aliccd -h='hosts' -s='seeds' -p='port' -t='tag' -n='name'"
    echo ""
    echo "This script launches a Cassandra of 'tag' cluster on 'hosts' with 'seeds' as seeds."
    echo ""
	echo "WARNING: force removal ... (to do)"
    echo "--help: print usage."
    echo "-h --hosts. Default: 'nc1 nc2 nc3 sc1 sc2 sc3 ec1 ec2 ec3'."
	echo "-s --seeds. Default: 'nc1 sc1 ec1'."
	echo "-p --ports. Default: '7000'."
	echo "-t --tag. Default: 'latest'"
	echo "-n --name. Default: ''"
    echo ""
}

hosts="nc1 nc2 nc3 sc1 sc2 sc3 ec1 ec2 ec3"	# run on all 9 ECSes
seeds="nc1 sc1 ec1"  # seeds in different regions
port="7000"  # port for gossip
tag="latest"  # cassandra:latest

# parse the arguments: --help, -h (--hosts), -s (--seeds), -t (--tag)
while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`

    case $PARAM in
        --help)
            usage
            exit
            ;;
	    -h | --hosts)
	    	hosts=$VALUE
	    	;;
		-s | --seeds)
			seeds=$VALUE
			;;
		-p |--port)
			port=$VALUE
			;;
		-t | --tag)
			tag=$VALUE
			;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

# first starting the seeds in 'seeds'

for seed in $seeds; do
	name=naming $seed
	ip=getIP $seed

	run_cmd="docker run --name $name -d -e CASSANDRA_BROADCAST_ADDRESS=$ip -p $port:$port cassandra:$tag"
	rm_cmd="docker rm -f $name"
	$run_cmd || ($rm_cmd && $run_cmd)
done

# then starting the others in 'hosts' (excluding those also in 'seeds')


for host in $hosts; do
	name=naming $host
	ip=getIP $host

	if [  ] ; then  # excluding those in 'seeds'
		# choose a random seed
		seed_ip=getIP ${seeds[$RANDOM % ${#seeds[@]} ]}
		run_cmd="docker run --name $name -d -e CASSANDRA_BROADCAST_ADDRESS=$ip -p $port:$port -e CASSANDRA_SEEDS=$seed_ip cassandra:$tag"
		rm_cmd='docker rm -f $name'
		$run_cmd || ($rm_cmd && $run_cmd)
	fi
done

function naming() {
	local h="$1"
	echo 'cassandra'-'$h'-'cluster'-'$name'
}

function getIP() {
	local h="$1"
    echo getent hosts $seed awk 'NR==1 {print $1}'
}
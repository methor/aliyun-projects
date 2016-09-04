#!/bin/bash
shopt -s extglob
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

#set -o nounset                              # Treat unset variables as an error

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
function naming() {
    local h="$1"
    echo 'cassandra'-"${h:0:2}"-'cluster'-"$h"
}

function getIP() {
    local h="$1"
    echo $(getent hosts $h | awk '{print $1}')
}

hosts=("nc1" "nc2" "nc3" "sc1" "sc2" "sc3" "ec1" "ec2" "ec3")	# run on all 9 ECSes
seeds=("nc1" "sc1" "ec1")  # seeds in different regions
port="7000"  # port for gossip
tag="latest"  # cassandra:latest

# parse the arguments: --help, -h (--hosts), -s (--seeds), -t (--tag)
option="$1"
shift

if [ 0 -ne $# ]; then
    until  [ -z "$1" ]
    do
        PARAM=`echo $1 | awk -F= '{print $1}'`
        VALUE=`echo $1 | awk -F= '{print $2}'`


        VALUE_ARR=()
        for item in "$VALUE"; do
            VALUE_ARR+=("$item")
        done


        case $PARAM in
            -h | --hosts)
                hosts=( ${VALUE_ARR[@]} )
                echo ${hosts[@]}
                ;;
            -s | --seeds)
                seeds=( ${VALUE_ARR[@]} )
                ;;
            -p |--port)
                port=( ${VALUE_ARR[@]} )
                ;;
            -t | --tag)
                tag=( ${VALUE_ARR[@]} )
                ;;
            *)
                echo "ERROR: unknown option \"$PARAM\""
                exit 1
                ;;
        esac
        shift
    done
fi

# comma-delimited seed ip list to be set in CASSANDRA_SEEDS option of seed hosts.
seeds_ip=()
for seed in ${seeds[@]}; do
    seeds_ip+=($(getIP $seed))
done
seeds_ip="${seeds_ip[*]}"
seeds_ip="${seeds_ip%% }"
comma_seeds_ip="${seeds_ip// /,}"


if [ "$option" = "rm" ] || [ "$option" = "start" ]; then
    for host in ${hosts[@]}; do


        name=$(naming $host)


        rm_cmd="docker rm -f $name"
        alish "exec" -r "$rm_cmd" -t "$host"
    done
fi

if [ "$option" = "start" ]; then
    # first starting the seeds in 'seeds'
    for ((i=0; i<${#seeds[@]}; i++)); do
        ip=$(getIP "${seeds[i]}")
        name=$(naming "${seeds[i]}")
        run_cmd="docker run --name $name -d -e CASSANDRA_BROADCAST_ADDRESS=$ip -e CASSANDRA_CLUSTER_NAME=DisAlg -e CASSANDRA_SEEDS=$comma_seeds_ip -e CASSANDRA_DC="${name:0:2}" -p $port:$port cassandra:$tag"
        alish "exec" -r "$run_cmd" -t "${seeds[i]}"
    done

    # then starting the others in 'hosts' (excluding those also in 'seeds')
    sleep 30

    for host in ${hosts[@]}; do
        name=$(naming $host)
        ip=$(getIP $host)

        if [[ "${seeds[*]}" != *"$host"* ]]; then
            # choose a random seed

            seed_ip=$(getIP ${seeds[$RANDOM % ${#seeds[@]}] })
            run_cmd="docker run --name $name -d -e CASSANDRA_BROADCAST_ADDRESS=$ip -p $port:$port -e CASSANDRA_SEEDS=$comma_seeds_ip -e CASSANDRA_DC="${name:0:2}" -e CASSANDRA_CLUSTER_NAME=DisAlg  cassandra:$tag"
            alish "exec" -r "$run_cmd" -t "$host"
            sleep 60
        fi
    done
fi

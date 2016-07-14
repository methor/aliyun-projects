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
    echo "aliccd -t='hosts' -s='seeds'"
    echo ""
    echo "This script ."
    echo ""
    echo "-h --help"
    echo "-t --hosts. Default: 'nc1 nc2 nc3 sc1 sc2 sc3 ec1 ec2 ec3'."
	echo "-s --seeds. Default: 'nc1 sc1 ec1'."
    echo ""
}

hosts="nc1 nc2 nc3 sc1 sc2 sc3 ec1 ec2 ec3"	# run on all 9 ECSes

# parse the arguments: -h (--help), -t (--hosts), -s (--seeds)
while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`

    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
	    -t | --hosts)
	    	hosts=$VALUE
	    	;;
		-s | --seeds)
			seeds=$VALUE
			;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

# first starting the seeds

# then starting the others
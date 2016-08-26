#!/bin/bash - 
#===============================================================================
#
#          FILE: alicp.sh
# 
#         USAGE: alicp.sh -l='local file/dir' -r='remote dir' -t='remote hosts'
# 
#   DESCRIPTION: This script 'alicp' copy local file/dir to dir on remote hosts.
# 
#       OPTIONS: -h --help
# 				 -l --local
#				 -r --remote
#				 -t --hosts
#  REQUIREMENTS: The option '-l' is required.
#          BUGS: ---
#         NOTES: Pay more attention to the trailing slash issues at the end of 
# 				directory arguments.
#        AUTHOR: Hengfeng Wei (ant-hengxin) 
#  ORGANIZATION: ICS, NJU
#       CREATED: 2016-08-25 17:16
#      REVISION:  ---
#===============================================================================

ldir=""
rdir="~/"
hosts="nc1 nc2 nc3 sc1 sc2 sc3 ec1 ec2 ec3"

function usage() {
    echo "alicp -l='local file/dir' -r='remote dir' -t='hosts'"
    echo ""
    echo "This script 'alicp' copy local file/dir to dir on remote hosts."
    echo ""
    echo "-h --help"
    echo "-l --local local file/dir. Required. No default value."
    echo "-r --remote remote dir. Default: '~/' meaning the home dir."
    echo "-t --hosts. Default: 'nc1 nc2 nc3 sc1 sc2 sc3 ec1 ec2 ec3'."
    echo ""
}

# parse the arguments: -h, -s, -d, -t
while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        -l | --local)
            ldir=$VALUE
            ;;
		-r | --remote)
            rdir=$VALUE
            ;;
		-t | --hosts)
			hosts=$VALUE
			;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

if [ "$ldir" = "" ]; then
	echo "ERROR: '-l or --local' option which specifies the local file or directory to copy is required."
	usage
	exit 1
fi

echo ""
echo "local file/dir is '$ldir'."
echo "remote cmd is '$rdir'."
echo "hosts is '$hosts'."
echo ""

# Remote copy: see [Copy folders (not one file) using SSH ubuntu?](http://askubuntu.com/a/446726/306000)
# rsync: -a: a combination flag; -v: verbose; -z: compression; -P: show progress
# See also [How To Use Rsync to Sync Local and Remote Directories](https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps)
for host in $hosts; do
	echo "$host:"	
	rsync -avzP -e 'ssh' $ldir root@$host:$rdir &
done
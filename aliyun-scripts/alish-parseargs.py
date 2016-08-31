import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-l", "--left", help="local command", default=None)
parser.add_argument("-r", "--right", help="remote command", default=None)
parser.add_argument("-t", "--hosts", help="hosts names", default=None)

args = parser.parse_args()

f = open('tmpfile', 'w')

if args.left:
    f.write(args.left + "\n")
else:
    f.write("\n")
if args.right:
    f.write(args.right + "\n")
else:
    f.write("\n")
if args.hosts:
    f.write(args.hosts + "\n")
else:
    f.write("\n")

f.close()


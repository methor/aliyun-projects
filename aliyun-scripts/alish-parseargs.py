import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-l", "--local", help="local command", default=None)
parser.add_argument("-r", "--remote", help="remote command", default=None)
parser.add_argument("-t", "--hosts", help="hosts names", default=None)

args = parser.parse_args()

f = open('tmpfile', 'w')

if args.local:
    f.write(args.local + "\n")
else:
    f.write("\n")
if args.remote:
    f.write(args.remote + "\n")
else:
    f.write("\n")
if args.hosts:
    f.write(args.hosts + "\n")
else:
    f.write("\n")

f.close()


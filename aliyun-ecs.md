# Aliyun ECS (Elastic Compute Service)

## Login (from Local Machines)

### Default Root Login
- `ssh root@<IP>`
- enter the password

### Login with Hostnames
Adding the content of [aliyun-hosts](https://bitbucket.org/hengxin/personal-info/src/cce61a4ff163c1f87e5abc4d164622df20690e50/accounts/aliyun-hosts?at=master&fileviewer=file-view-default) to your `hosts` file, then you can login via `ssh root@<hostname>` (with password).

### Login via SSH Keys
*Note:* The following documents the way how [the article: How To Set Up SSH Keys](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2) sets up ssh keys. 
Please contact me for the private key if you need.

1. `ssh-keygen -t rsa`: Create the RSA Key Pair
2. Store the Keys and Passphrase: by default, it is `~/.ssh/id_rsa`
3. `ssh-copy-id user@123.45.56.78`: Copy the Public Key onto the Remote Server

Now you can login via `ssh root@<IP>` or `ssh root@<hostname>` *without* entering password every time.

## Configurations

### [Install Docker](https://github.com/hengxin/cheat-sheets/tree/master/docker-cheat-sheets)
- `wget -qO- https://get.docker.com/ | sh`
- *already on*: `sc2`, `nc1`

### Cassandra in Docker
- `docker pull cassandra`
- *already on*: `sc2`, `nc1`

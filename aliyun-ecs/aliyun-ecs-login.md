# Login Aliyun ECS

## Default Root Login
- `ssh root@<IP>` (*Find all IPs in [file: aliyun-hosts](https://github.com/hengxin/aliyun-projects/blob/master/aliyun-ecs/aliyun-hosts)*)
- enter the password

### Console at Aliyun Service
- password for console: 861102
- user: root
- then enter the password for ecs

## Login with Hostnames
Adding the content of [aliyun-hosts](https://github.com/hengxin/aliyun-projects/blob/master/aliyun-ecs/aliyun-hosts) to your hosts file (for example, `/etc/hosts` in Ubuntu), 
then you can login via `ssh root@<hostname>` (still with password).

## Login via SSH Keys
*Note:* The following documents the way how [the article: How To Set Up SSH Keys](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2) sets up ssh keys. 
Please contact me for the private key.

1. `ssh-keygen -t rsa`: create the RSA key pair
2. store the keys and passphrase: by default, it is `~/.ssh/id_rsa`
3. `ssh-copy-id user@123.45.56.78`: copy the public key onto the remote server

Now you can login via `ssh root@<IP>` or `ssh root@<hostname>` *without* entering password every time.

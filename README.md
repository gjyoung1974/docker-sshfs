## docker-sshfs: serve a Kubernetes persistent volume over SSH
### Usecase: remotely mount a Persistent Volume via Fuse SSHFS

### Overview
Use this Dockerfile / -image to start a sshd-server upon a lightweight Alpine container.

### Features
* Installs the latest OpenSSH-Version available for Alpine
* Password of "root"-user can be changed when starting the container using --env
* Public SSH key of "root"-user can be changed when starting the container using --env

### Basic Docker Usage
```
$ docker run --rm \
--publish=1234:22 \
--env ROOT_PASSWORD=MyRootPW123 \
# or use an RSA key
# --env ROOT_AUTHORIZED_KEY="<some public key base64 string>" \
gjyoung1974/alpine-sshd
```
### Basic Kubernetes Usage
See the file: k8s-webapp-with-sshfs.yml

After the container is up you are able to ssh in it as root with the in --env provided password  or RSA keypair for "root"-user.
```
$ ssh root@mydomain.tld -p 1234
```
mount the remote filesystem locally with fuse:
https://github.com/osxfuse/osxfuse/wiki/SSHFS

```
function remote_fs(){
sshfs root@<some_remote_server>:/web_app_files ~/web_app_files/ -o auto_cache,reconnect,defer_permissions,noappledouble,IdentityFile=~/.ssh/id_rsa -p 1234 
}
```
//TODO 
Harden SSHD config


```
2017 Gordon young gjyoung1974@gmail.com
```


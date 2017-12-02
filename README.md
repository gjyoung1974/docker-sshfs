## A docker container to offer a Kubernetes Persistent Volume over SSH
### Usecase: remotely mount a Persistent Volume via Fuse SSHFS for purposes of remote repository management

### Overview
Use this Dockerfile / -image to start a sshd-server upon a lightweight Alpine container.

### Features
* Installs the latest OpenSSH-Version available for Alpine
* Password of "root"-user can be changed when starting the container using --env
* Public SSH key of "root"-user can be changed when starting the container using --env

### Basic Usage
```
$ docker run --rm \
--publish=1234:22 \
--env ROOT_PASSWORD=MyRootPW123 \
--env ROOT_AUTHORIZED_KEY="<some public key base64 string>" \
hermsi/alpine-sshd
```

After the container is up you are able to ssh in it as root with the in --env provided password  or RSA keypair for "root"-user.
```
$ ssh root@mydomain.tld -p 1234
```
mount the remote filesystem locally with fuse:
https://github.com/osxfuse/osxfuse/wiki/SSHFS

```
function remote_fs(){
sshfs root@<some_remote_server>:/remote_path ~/local_path/ -o auto_cache,reconnect,defer_permissions,noappledouble,IdentityFile=~/.ssh/id_rsa -p 1234 
}
```


```
2017 Gordon young gjyoung1974@gmail.com
```
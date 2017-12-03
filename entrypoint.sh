#!/bin/sh

# generate host keys if not present
ssh-keygen -A

# check wether a random root-password is provided
if [ ! -z ${ROOT_PASSWORD} ] && [ "${ROOT_PASSWORD}" != "root" ]; then
    echo "root:${ROOT_PASSWORD}" | chpasswd
fi

mkdir -p /root/.ssh
touch /root/.ssh/authorized_keys
echo ${ROOT_AUTHORIZED_KEY} > /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"

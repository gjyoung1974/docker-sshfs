FROM alpine:latest

LABEL maintainer "https://github.com/gjyoung1974"

ENV ROOT_PASSWORD root
ENV ROOT_AUTHORIZED_KEY root_pub_key

RUN apk --update add openssh \
		&& sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
		&& echo "root:${ROOT_PASSWORD}" | chpasswd \
		&& rm -rf /var/cache/apk/* /tmp/* \ 
		&& mkdir /root/.ssh/ && chmod 700 /root/.ssh \
		&& echo "root:${ROOT_PASSWORD}" > /root/.ssh/authorized_keys \
		&& chmod 600 /root/.ssh/authorized_keys

COPY entrypoint.sh /usr/local/bin/

EXPOSE 22

ENTRYPOINT ["entrypoint.sh"]

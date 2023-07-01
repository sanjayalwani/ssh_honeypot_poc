FROM ubuntu

COPY ./container_script.sh /container_script.sh
RUN chmod +x /container_script.sh

COPY ./sshd_config /etc/ssh/sshd_config

RUN apt update
RUN apt -y install ssh
RUN apt -y install strace

EXPOSE 22

ENTRYPOINT ["/container_script.sh"]

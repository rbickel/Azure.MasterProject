FROM debian:buster

# Steps done in one RUN layer:
# - Install packages
# - OpenSSH needs /var/run/sshd to run
# - Remove generic host keys, entrypoint generates unique keys
RUN apt-get update && \
    apt-get -y install openssh-server python3 ca-certificates \
                       curl apt-transport-https lsb-release gnupg cifs-utils && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd && \
    rm -f /etc/ssh/ssh_host_*key*

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

COPY ./sshd_config /etc/ssh/sshd_config
COPY ./create-sftp-user /usr/local/bin/
COPY ./entrypoint /

RUN chmod +x /entrypoint /usr/local/bin/create-sftp-user /etc/ssh/sshd_config

EXPOSE 22

ENTRYPOINT ["bash", "/entrypoint"]
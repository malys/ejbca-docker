from centos:8
maintainer Christian Felsing <support@felsing.net>

ENV SOURCE=remote
ENV DB_PATH=/home/ejbca/data

user root

run \
  echo 'http_caching=none' >> /etc/yum.conf

run \
  yum -y update \
  && yum -y install \
    java-1.8.0-openjdk-devel \
    ant \
    tar \
    unzip \
    psmisc \
    bc \
    patch

run yum -y install mysql postgresql

run \
  groupadd ejbca \
  && useradd -d /home/ejbca -g ejbca -s /bin/bash ejbca

ARG httpsserver_hostname
ARG database_host
ARG database_name
ARG database_username
ARG database_password
ARG database_type
ARG database_port
ARG superadmin_cn
ARG ca_name
ARG BASE_DN

copy ./entrypoint.sh /root/entrypoint.sh
run chown root:root /root/entrypoint.sh \
  && chmod 700 /root/entrypoint.sh
entrypoint ["/root/entrypoint.sh"]


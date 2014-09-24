# Docker image for supervisord. Based on https://github.com/Krijger/docker-cookbooks/tree/master/supervisor
# Use it as base image for multi process container
# To build, run docker build --rm --tag=jmarin/supervisord

FROM centos:latest
MAINTAINER Juan Marin Otero <juan.marin.otero@gmail.com>

# Update base image
RUN yum -y update; yum clean all
RUN yum -y install wget
RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm
RUN rpm -ivh epel-release-7-2.noarch.rpm

RUN yum -y install python-setuptools; yum clean all
RUN easy_install pip
RUN pip install supervisor
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /etc/supervisor/conf.d

# Add supervisor base configuration
ADD supervisor.conf /etc/supervisor/supervisor.conf

# Default command
CMD ["supervisord", "-c", "/etc/supervisor/supervisor.conf"]



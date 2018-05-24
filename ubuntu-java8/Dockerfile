FROM ubuntu:16.04

MAINTAINER jacob.koren@zooz.com

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Java 8
RUN   apt-get update  \
      && apt-get install -y software-properties-common \
      && apt-add-repository -y ppa:webupd8team/java \
      && apt-get purge --auto-remove -y software-properties-common \
      && apt-get update \
      && echo oracle-java-8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
      && apt-get install -y oracle-java8-installer \
      && apt-get install -y oracle-java8-set-default \
      && rm -rf /var/cache/oracle-jdk8-installer

# Curl
RUN apt-get install -y curl

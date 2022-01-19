FROM ubuntu:20.04

SHELL ["/bin/bash", "-c"]

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && \
    apt-get install -y build-essential binutils wget tzdata && \
    apt-get install -y apache2 git curl libtool zip nano ftp && \
    apt-get install --fix-missing && \
    apt-get clean

# Apache Setup
ADD config/apache/000-default.conf /etc/apache2/sites-enabled/
RUN a2enmod cgi \
  && ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/ \
  && ln -s /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/ \
  && echo "Free Pascal for Docker" > /var/www/html/index.html \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /projects/
WORKDIR /projects
ADD ./app/ /app

ENV FPC_VERSION="3.2.2"

# trunk: ftp://ftp.freepascal.org/pub/fpc/snapshot/trunk/source/fpc.zip
RUN ARCH=$(uname -m)-linux && \
    cd /tmp && \
    wget "ftp://ftp.freepascal.org/pub/fpc/dist/${FPC_VERSION}/${ARCH}/fpc-${FPC_VERSION}?${ARCH}.tar" -O fpc.tar && \
    tar xf fpc.tar && \
    cd fpc-${FPC_VERSION}?${ARCH} && \
    rm demo* doc* && \
    echo -e '\n' | ./install.sh && \
    rm -r /tmp/*

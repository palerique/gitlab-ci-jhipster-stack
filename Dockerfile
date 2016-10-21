FROM ubuntu:xenial
MAINTAINER Paulo Henrique Lerbach Rodrigues <palerique@gmail.com>

RUN \
# configure user
  groupadd docker && \
  usermod -aG docker root

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

RUN echo "deb http://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list

# install open-jdk 8
RUN apt-get update && \
  apt-get install -y openjdk-8-jdk && \

# install utilities
  apt-get install -y \
     wget \
     curl \
     vim \
     git \
     zip \
     bzip2 \
     fontconfig \
     python \
     g++ \
     build-essential \
     apt-transport-https \
     ca-certificates;

# install node.js
RUN  curl -sL http://deb.nodesource.com/setup_4.x | bash && \
  apt-get install -y nodejs;

# upgrade npm
RUN npm install -g npm;

# install yeoman bower gulp
RUN npm install -g \
    yo \
    bower \
    gulp-cli;

# install docker
RUN apt-get install -y --force-yes docker-engine;
RUN service docker start;
RUN systemctl enable docker;

# install docker-compose
RUN curl -L "http://github.com/docker/compose/releases/download/1.8.1/docker-compose-$(uname -s)-$(uname -m)" > /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose;

# install docker-cloud
RUN apt-get install -y --force-yes python-pip && \
  pip install docker-cloud;

# cleanup
RUN apt-get clean && \
  apt-get -y --force-yes autoremove && \
  apt-get -y --force-yes autoclean && \
  rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*;

# install jhipster
RUN npm install -g generator-jhipster;

# cleanup
RUN apt-get clean && \
  apt-get -y --force-yes autoremove && \
  apt-get -y --force-yes autoclean && \
  rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*;

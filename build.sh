#!/bin/sh

set -x

# ===================== #
# Script configuration. #
# ===================== #

DOCKER_CONTAINER_NAME=kafka
# Set the version of the base image.
DOCKER_ORIGIN=alpine:3.7

cat - >Dockerfile <<EOF
FROM ${DOCKER_ORIGIN}

MAINTAINER Kumar Rohit <https://github.com/kuros/docker-kafka>

USER root
#  && \

# Install Java
RUN apk update && \\
	apk upgrade && \\
	apk add openjdk8-jre && \\
	apk add curl && \\
	apk add tar

ADD http://www-eu.apache.org/dist/kafka/1.0.0/kafka_2.11-1.0.0.tgz /tmp

RUN mkdir kafka && tar -xzf kafka_2.11-1.0.0.tgz -C /kafka --strip-components 1

CMD [`echo 'hello'`]

EOF

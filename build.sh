#!/bin/sh

set -x

# ===================== #
# Script configuration. #
# ===================== #

DOCKER_CONTAINER_NAME=kafka
# Set the version of the base image.
DOCKER_ORIGIN=openjdk:8-jre-alpine3.7

cat - >Dockerfile <<EOF
FROM ${DOCKER_ORIGIN}

MAINTAINER Kumar Rohit <https://github.com/kuros/docker-kafka>

USER root
#  && \

ADD http://www-eu.apache.org/dist/kafka/1.0.0/kafka_2.11-1.0.0.tgz /tmp

# Install Java
RUN apk update && \\
	apk upgrade && \\
	apk add tar


RUN mkdir kafka && \\
	tar -xzf /tmp/kafka_2.11-1.0.0.tgz -C /kafka --strip-components 1 && \\
	rm -rf /tmp

CMD [`echo 'hello'`]

EOF

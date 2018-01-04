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

# Install Java
RUN apk update && \\
	apk upgrade && \\
	apk add tar && \\
	apk add bash && \\
	apk add wget

RUN wget -q http://www-eu.apache.org/dist/kafka/1.0.0/kafka_2.11-1.0.0.tgz --output-document=/tmp/kafka.tgz && \\
	mkdir kafka && \\
	tar -xzf /tmp/kafka.tgz -C /kafka --strip-components 1 && \\
	rm -rf /tmp/kafka*

ENV BROKER_ID=1

COPY start.sh /start.sh
RUN chmod a+x start.sh

CMD ["./start.sh"]

EOF

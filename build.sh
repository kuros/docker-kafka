#!/bin/sh

set -x

# ===================== #
# Script configuration. #
# ===================== #

DOCKER_CONTAINER_NAME=kafka
# Set the version of the base image.
DOCKER_ORIGIN=openjdk:8-jre-alpine3.7
KAFKA_VERSION=1.0.0
KAFKA_SCALA_VERION=2.11

cat - >Dockerfile <<EOF
FROM ${DOCKER_ORIGIN}

MAINTAINER Kumar Rohit <https://github.com/kuros/docker-kafka>

USER root

# Downlaod Kafka & install
RUN apk update && \\
	apk upgrade && \\
	apk add tar && \\
	apk add bash && \\
	apk add wget && \\
	wget -q http://www-eu.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${KAFKA_SCALA_VERION}-${KAFKA_VERSION}.tgz --output-document=/tmp/kafka.tgz && \\
	mkdir kafka && \\
	tar -xzf /tmp/kafka.tgz -C /kafka --strip-components 1 && \\
	rm -rf /tmp/kafka* \\
	apk del tar wget && \\
	rm -rf /var/cache/apk/*


# Set up a user to run Kafka
RUN addgroup kafka && \\
  adduser -D -h /kafka -G kafka kafka && \\
  mkdir /data && \\
  chown -R kafka:kafka /kafka /data	

USER kafka

EXPOSE 2181 9092

VOLUME ['/data']

COPY start.sh /start.sh
CMD ["./start.sh"]

EOF

docker build -t ${DOCKER_CONTAINER_NAME} .


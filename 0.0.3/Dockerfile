FROM openjdk:8-jre-alpine3.7
	
MAINTAINER Kumar Rohit <https://github.com/kuros/docker-kafka>

USER root

# Downlaod Kafka & install
RUN apk update && \
	apk upgrade && \
	apk add tar && \
	apk add bash && \
	apk add wget && \
	wget -q http://www-eu.apache.org/dist/kafka/1.0.0/kafka_2.11-1.0.0.tgz --output-document=/tmp/kafka.tgz && \
	mkdir kafka && \
	tar -xzf /tmp/kafka.tgz -C /kafka --strip-components 1 && \
	rm -rf /tmp/kafka* \
	apk del tar wget && \
	rm -rf /var/cache/apk/*

EXPOSE 2181 9092

VOLUME ['/data']

COPY start.sh /start.sh
CMD ["/start.sh"]


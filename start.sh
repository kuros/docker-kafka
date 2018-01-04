#!/bin/bash

cat /kafka/config/server.properties \
	| sed -e "s/broker.id=0/broker.id=${BROKER_ID:-0}/g" \
	> /kafka/config/server.properties.new

mv /kafka/config/server.properties.new /kafka/config/server.properties

./kafka/bin/zookeeper-server-start.sh -daemon /kafka/config/zookeeper.properties
sleep 4
./kafka/bin/kafka-server-start.sh /kafka/config/server.properties
#!/bin/bash

cat /kafka/config/server.properties \
	| sed -e "s/broker.id=0/broker.id=${KAFKA_BROKER_ID:-0}/g" \
	-e "s/num.network.threads=3/num.network.threads=${NUM_NETWORK_THREADS:-3}/g" \
	-e "s/num.io.threads=8/num.io.threads=${NUM_IO_THREADS:-8}/g" \
	-e "s/socket.send.buffer.bytes=102400/socket.send.buffer.bytes=${SCOKET_SEND_BUFFER_BYTES:-102400}/g" \
	-e "s/socket.receive.buffer.bytes=102400/socket.receive.buffer.bytes=${SOCKET_RECEIVE_BUFFER_BYTES:-102400}/g" \
	-e "s/socket.request.max.bytes=104857600/socket.request.max.bytes=${SOCKET_REQUEST_MAX_BYTES:-104857600}/g" \
	-e "s|log.dirs=/tmp/kafka-logs|log.dirs=/data|g" \
	-e "s/num.partitions=1/num.partitions=${NUM_PARTITIONS:-1}/g" \
	-e "s/num.recovery.threads.per.data.dir=1/num.recovery.threads.per.data.dir=${NUM_RECOVERY_THREADS_PER_DATA_DIR:-1}/g" \
	-e "s/offsets.topic.replication.factor=1/offsets.topic.replication.factor=${OFFSETS_TOPIC_REPLICATION_FACTOR:-1}/g" \
	-e "s/transaction.state.log.replication.factor=1/transaction.state.log.replication.factor=${TRANSACTION_STATE_LOG_REPLICATION_FACTOR:-1}/g" \
	-e "s/transaction.state.log.min.isr=1/transaction.state.log.min.isr=${TRANSACTION_STATE_LOG_MIN_ISR:-1}/g" \
	-e "s/log.retention.hours=168/log.retention.hours=${LOG_RETENTION_HOURS:-168}/g" \
	-e "s/log.segment.bytes=1073741824/log.segment.bytes=${LOG_SEGMENT_BYTES:-1073741824}/g" \
	-e "s/log.retention.check.interval.ms=300000/log.retention.check.interval.ms=${LOG_RETENTION_CHECK_INTERVAL:-300000}/g" \
	-e "s/zookeeper.connect=localhost:2181/zookeeper.connect=${ZOOKEEPER_CONNECT:-localhost:2181}/g" \
	-e "s/zookeeper.connection.timeout.ms=6000/zookeeper.connection.timeout.ms=${ZOOKEEPER_CONNECTION_TIMEOUT:-6000}/g" \
	-e "s/group.initial.rebalance.delay.ms=0/group.initial.rebalance.delay.ms=${GROUP_INITIAL_REBALANCE_DELAY_MS:-0}/g" \
	> /kafka/config/server.properties.new

mv /kafka/config/server.properties.new /kafka/config/server.properties

if [[ ${INIT_KAFKA_ZOOKEEPER}  ]]; then
	echo 'Starting zookeeper'
	./kafka/bin/zookeeper-server-start.sh -daemon /kafka/config/zookeeper.properties
	sleep 4	
	echo 'Zookeeper started'
fi

echo 'Starting Kafka server'
./kafka/bin/kafka-server-start.sh /kafka/config/server.properties
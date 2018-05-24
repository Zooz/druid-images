FROM paymentsos/druid-base:ubuntu14java8

MAINTAINER jacob.koren@zooz.com

ENV DRUID_DIR=/druid-0.12.0
ENV DRUID_PROP_DIR=/druid-0.12.0/conf/druid/_common/

RUN curl http://static.druid.io/artifacts/releases/druid-0.12.0-bin.tar.gz --output druid-0.12.0-bin.tar.gz
COPY mysql-metadata-storage-0.12.0.tar.gz /
RUN mkdir -p $DRUID_DIR/extensions/graphite-emitter && mkdir -p $DRUID_DIR/extensions/statsd-emitter
COPY statsd-emitter $DRUID_DIR/extensions/statsd-emitter

RUN tar -xzf druid-0.12.0-bin.tar.gz \
	&& tar -xzf mysql-metadata-storage-0.12.0.tar.gz \
	&& sudo mv mysql-metadata-storage $DRUID_DIR/extensions/

RUN find $DRUID_DIR/conf/druid -name jvm.config | while read line; do sed -i "s/var\/tmp/\/var\/tmp/g" $line; done

COPY common.runtime.properties.old $DRUID_PROP_DIR
COPY jets3t.properties $DRUID_PROP_DIR

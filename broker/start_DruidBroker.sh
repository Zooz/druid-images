#!/bin/sh
echo "Installing broker services: druid broker……"
DRUID_DIR=/druid-0.9.2

cd $DRUID_DIR

CONF_DIR=$DRUID_DIR/conf/druid/broker

echo druid.host=broker.$FRAMEWORK_NAME.mesos:$PORT0 >> $CONF_DIR/runtime.properties
sed -i "s/TELEGRAF_HOST/$HOST/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/TELEGRAF_PORT/$TELEGRAF_PORT/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/TELEGRAF_PREFIX/$TELEGRAF_PREFIX/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties

sed -i "s/DBUser/$DBUser/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/DBPass/$DBPass/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/DBHost/$DBHost/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/ZKIP/$ZKip/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties

cat $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/druid.port=8082/druid.port=$PORT0/g" $CONF_DIR/runtime.properties

# Run
echo "Deploying Broker services ..."

sed -i  "s/-Xms24g/-Xms2g/g" $DRUID_DIR/conf/druid/broker/jvm.config
sed -i  "s/-Xmx24g/-Xmx2g/g" $DRUID_DIR/conf/druid/broker/jvm.config

exec java `cat conf/druid/broker/jvm.config | xargs` -cp conf/druid/_common:conf/druid/broker:lib/* io.druid.cli.Main server broker

EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ];
then
    echo "Error installing druid services"
    exit $EXIT_CODE
fi

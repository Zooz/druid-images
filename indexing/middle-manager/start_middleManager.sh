#!/bin/sh
echo "Running druid middleManager node"
DRUID_DIR=/druid-0.12.0
SCRIPTS_HOME=$DRUID_DIR/bin/deployment

cd $DRUID_DIR
CONF_DIR=$DRUID_DIR/conf/druid/middleManager

echo druid.host=$HOST:$PORT0 >> $CONF_DIR/runtime.properties
sed -i "s/druid.port=8091/druid.port=$PORT0/g" $CONF_DIR/runtime.properties
sed -i "s/druid.port=8100/druid.port=$PORT1/g" $CONF_DIR/runtime.properties
sed -i "s/druid.worker.capacity=3/druid.worker.capacity=$TASKS/g" $CONF_DIR/runtime.properties

sed -i "s/TELEGRAF_HOST/$HOST/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/TELEGRAF_PORT/$TELEGRAF_PORT/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/TELEGRAF_PREFIX/$TELEGRAF_PREFIX/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties

sed -i "s/DBUser/$DBUser/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/DBPass/$DBPass/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/DBHost/$DBHost/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/ZKIP/$ZKip/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties

sed -i "s/Xmx64m/Xmx1024m/g" $CONF_DIR/jvm.config
sed -i "s/Xms64m/Xms128m/g" $CONF_DIR/jvm.config

sed -i "s/DeepStorageBucket/$DSBUCKET/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties

echo "druid.indexer.logs.directory=$MESOS_SANDBOX" >> $CONF_DIR/runtime.properties

echo druid.indexer.logs.kill.durationToRetain=60000 >> $CONF_DIR/runtime.properties

exec java `cat conf/druid/middleManager/jvm.config | xargs` -cp conf/druid/_common:conf/druid/middleManager:lib/* io.druid.cli.Main server middleManager

EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ];
then
    echo "Error installing druid services"
    cd $DRUID_DIR
    #exit $EXIT_CODE
fi

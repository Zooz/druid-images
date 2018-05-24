#!/bin/sh
echo "Installing druid historical node"
DRUID_DIR=/druid-0.12.0

cd $DRUID_DIR
echo "Deploying Historical node ..."

CONF_DIR=$DRUID_DIR/conf/druid/historical

echo druid.host=$HOST:$PORT0 >> $CONF_DIR/runtime.properties
sed -i "s/druid.port=8083/druid.port=$PORT0/g" $CONF_DIR/runtime.properties
sed -i "s/druid.processing.numThreads=.*/druid.processing.numThreads=$HISTORICAL_THREADS/g" $CONF_DIR/runtime.properties
sed -i "s/TELEGRAF_HOST/$HOST/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/TELEGRAF_PORT/$TELEGRAF_PORT/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/TELEGRAF_PREFIX/$TELEGRAF_PREFIX/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties

sed -i "s/DBUser/$DBUser/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/DBPass/$DBPass/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/DBHost/$DBHost/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/ZKIP/$ZKip/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/DeepStorageBucket/$DSBUCKET/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/MONITORS/\[\"io.druid.java.util.metrics.JvmMonitor\", \"io.druid.server.metrics.HistoricalMetricsMonitor\"\]/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties

echo druid.server.tier=$TIER >> $CONF_DIR/runtime.properties

exec java `cat conf/druid/historical/jvm.config | xargs` -cp conf/druid/_common:conf/druid/historical:lib/* io.druid.cli.Main server historical
#java `cat conf/druid/historical/jvm.config | xargs` -cp conf/druid/_common:conf/druid/historical:lib/* io.druid.cli.Main server historical &
EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ];
then
    echo "Error installing druid services."
    cd $DRUID_DIR
    #exit $EXIT_CODE
fi

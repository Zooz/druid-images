#!/bin/sh
echo "Running overloard node"
DRUID_DIR=/druid-0.12.0

cd $DRUID_DIR
CONF_DIR=$DRUID_DIR/conf/druid/overlord

echo druid.host=overlord.$FRAMEWORK_NAME.mesos:$PORT0 >> $CONF_DIR/runtime.properties
sed -i "s/druid.port=8090/druid.port=$PORT0/g" $CONF_DIR/runtime.properties
echo "druid.indexer.logs.directory=$MESOS_SANDBOX" >> $CONF_DIR/runtime.properties

sed -i "s/TELEGRAF_HOST/$HOST/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/TELEGRAF_PORT/$TELEGRAF_PORT/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/TELEGRAF_PREFIX/$TELEGRAF_PREFIX/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties

sed -i "s/DBUser/$DBUser/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/DBPass/$DBPass/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/DBHost/$DBHost/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties

sed -i "s/ZKIP/$ZKip/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/ZKPATH/$ZKpath/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties

sed -i  "s/-Xms3g/-Xms1g/g" $DRUID_DIR/conf/druid/overlord/jvm.config
sed -i  "s/-Xms3g/-Xms1g/g" $DRUID_DIR/conf/druid/overlord/jvm.config

sed -i "s/MONITORS/\[\"io.druid.java.util.metrics.JvmMonitor\"]/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties

exec java `cat conf/druid/overlord/jvm.config | xargs` -cp conf/druid/_common:conf/druid/overlord:lib/* io.druid.cli.Main server overlord

EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ];
then
    echo "Error installing druid services."
    cd $DRUID_DIR
    #exit $EXIT_CODE
fi

#!/bin/sh
echo "Installing coordinator node"
DRUID_DIR=/druid-0.9.2
SCRIPTS_HOME=$DRUID_DIR/bin/deployment

cd $DRUID_DIR

CONF_DIR=$DRUID_DIR/conf/druid/coordinator

echo druid.host=coordinator.$FRAMEWORK_NAME.mesos:$PORT0 >> $CONF_DIR/runtime.properties
sed -i "s/druid.port=8081/druid.port=$PORT0/g" $CONF_DIR/runtime.properties
sed -i "s/TELEGRAF_HOST/$HOST/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/TELEGRAF_PORT/$TELEGRAF_PORT/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/TELEGRAF_PREFIX/$TELEGRAF_PREFIX/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties

sed -i "s/DBUser/$DBUser/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/DBPass/$DBPass/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/DBHost/$DBHost/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties
sed -i "s/ZKIP/$ZKip/g" $DRUID_DIR/conf/druid/_common/common.runtime.properties

sed -i  "s/-Xms3g/-Xms1g/g" $CONF_DIR/jvm.config

echo "Running coordinator node"

java `cat conf/druid/coordinator/jvm.config | xargs` -cp conf/druid/_common:conf/druid/coordinator:lib/* io.druid.cli.Main server coordinator
 #java `cat conf/druid/coordinator/jvm.config | xargs` -cp conf/druid/_common:conf/druid/coordinator:lib/* io.druid.cli.Main server coordinator  &
EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ];
then
    echo "Error installing druid services."
    cd $DRUID_DIR
    #exit $EXIT_CODE
fi

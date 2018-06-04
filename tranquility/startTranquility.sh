#!/bin/bash -x

tar xvf /tranquility-distribution-0.8.1.tgz
tar xvf /kafka_2.11-0.11.0.0.tgz
mv /tranquility-distribution-0.8.1 /tranquility

filename=$(echo $METRICS_CONFIG | rev | cut -d'/' -f1 | rev);

~/local/bin/aws s3 cp $METRICS_CONFIG /mnt/mesos/sandbox/$filename.template

awk -v port=$PORT1 '{gsub(/<PORT>/,port);print}' /mnt/mesos/sandbox/$filename.template > /mnt/mesos/sandbox/$filename

# If you want to run tranquility http server as well
#/tranquility/bin/tranquility server -configFile /mnt/mesos/sandbox/$filename &

while true; do { ./checkHealth.sh;} | nc -l $PORT0; done &

exec /tranquility/bin/tranquility kafka -configFile /mnt/mesos/sandbox/$filename

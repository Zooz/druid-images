FROM BASE_IMAGE

COPY startTranquility.sh /
RUN curl http://static.druid.io/tranquility/releases/tranquility-distribution-0.8.1.tgz --output tranquility-distribution-0.8.1.tgz
COPY kafka_2.11-0.11.0.0.tgz /
COPY checkHealth.sh /

RUN apt-get update &&  apt-get install -y openssl

ENTRYPOINT ["/startTranquility.sh"]

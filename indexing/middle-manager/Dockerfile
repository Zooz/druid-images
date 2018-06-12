FROM BASE_IMAGE

ENV DRUID_DIR=/root/druid-0.12.0
COPY hadoop-aws-2.7.3.jar $DRUID_DIR/lib/
COPY start_middleManager.sh /

RUN cd /druid-0.12.0/quickstart/ && gzip -d wikiticker-2015-09-12-sampled.json.gz

ENTRYPOINT ["/start_middleManager.sh"]

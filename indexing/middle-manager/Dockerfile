FROM BASE_IMAGE

ENV DRUID_DIR=/root/druid-0.9.2
COPY start_middleManager.sh /

RUN cd /druid-0.9.2/quickstart/ && gzip -d wikiticker-2015-09-12-sampled.json.gz

ENTRYPOINT ["/start_middleManager.sh"]

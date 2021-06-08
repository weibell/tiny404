FROM alpine

RUN apk add --no-cache \
  tini \
  socat

COPY ./tiny404.sh /

ENV STATUS_CODE=404
ENV BODY=""

EXPOSE 80
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/tiny404.sh"]

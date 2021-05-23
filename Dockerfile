FROM alpine

RUN apk add --no-cache nmap-ncat
COPY ./tiny404.sh /

ENV STATUS_CODE=404
ENV BODY=""

EXPOSE 80
CMD ["/tiny404.sh"]

HEALTHCHECK CMD nc -z localhost 80 || exit 1

FROM alpine

RUN apk add --no-cache nmap-ncat
COPY ./start.sh /

EXPOSE 80
CMD ["/start.sh"]

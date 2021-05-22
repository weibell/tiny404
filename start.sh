#!/bin/sh

case $STATUS_CODE in
  200) REASON="OK";;
  401) REASON="Unauthorized";;
  403) REASON="Forbidden";;
  404) REASON="Not Found";;
  500) REASON="Internal Server Error";;
  *)   REASON="Not Found"; STATUS_CODE=404
esac

STATUS_LINE="HTTP/1.1 ${STATUS_CODE} ${REASON}\r\n"
HEADER_FIELDS="Connection: close\r\nContent-Length: 0\r\n\r\n"

COUNTER=1
while true ; do
  printf "${STATUS_LINE}${HEADER_FIELDS}" | ncat -l 80 --nodns --send-only
  echo "[$(date -u +%FT%TZ)] Request #${COUNTER}" && COUNTER=$((COUNTER+1))
done

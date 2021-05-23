#!/bin/sh

create_payload() {
  local reason
  case $STATUS_CODE in
    200) reason="OK";;
    401) reason="Unauthorized";;
    403) reason="Forbidden";;
    404) reason="Not Found";;
    500) reason="Internal Server Error";;
    *)   STATUS_CODE=404; reason="Not Found"
  esac

  local body=""
  if [ -n "$BODY" ]; then local body="${BODY}\n"; fi
  local status_line="HTTP/1.1 ${STATUS_CODE} ${reason}\r\n"
  local header_fields="Connection: close\r\nContent-Length: $(printf "$body" | wc -c)\r\n\r\n"

  PAYLOAD="${status_line}${header_fields}${body}"
}

respond_to_request() {
  printf "$PAYLOAD" | ncat -l 80 --nodns --send-only
}

log_counter() {
  COUNTER=$((COUNTER+1))
  echo "[$(date -u +%FT%TZ)] Request #${COUNTER}"
}

create_payload
while true; do
  respond_to_request
  log_counter
done

#!/bin/sh

create_response() {
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

  RESPONSE="${status_line}${header_fields}${body}"
}
create_response

socat -v -t0 TCP-LISTEN:80,reuseaddr,fork SYSTEM:"echo \"\\\"$RESPONSE\\\"\"" 2>&1

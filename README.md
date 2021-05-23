# tiny404

Tiny Docker container responding to any request with a minimal HTTP 404 (or other) response.


## Usage

```sh
docker run -d -p 80:80 weibell/tiny404
```

Equivalent `docker-compose.yml` file:

```yaml
version: "3"
services:
  web:
    image: weibell/tiny404
    ports:
      - "80:80"
```


## Environment variables

| Variable  | Default | Possible Values |
| - | - | - |
| `STATUS_CODE` | `404` | `200`, `401`, `403`, `404`, `500` |
| `BODY` | `""` | arbitrary |


Example:

```sh
docker run -d -p 80:80 -e STATUS_CODE=403 -e BODY="403\nForbidden" weibell/tiny404
```

Equivalent `docker-compose.yml` file:

```yaml
version: "3"
services:
  web:
    image: weibell/tiny404
    ports:
      - "80:80"
    environment:
      - STATUS_CODE=403
      - BODY="403\nForbidden"
```


## Implementation notes

`tiny404.sh` relies on specific behavior of netcat's `-q` option, which should cause the listener to terminate the connection upon reading EOF from stdin. Unfortunately, this behaviour is present in neither Alpine's `netcat-openbsd` nor BusyBox's `nc`. Therefore, `nmap-ncat` is used with the `--send-only` option (documented [here](https://secwiki.org/w/Ncat/EOF_behavior)) instead.

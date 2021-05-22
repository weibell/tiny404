# tiny404

A tiny Docker container responding to any request with a minimal HTTP 404 response.


## Usage

```bash
docker run -d -p 80:80 weibell/tiny404
```

Equivalent `docker-compose.yml` file:

```docker-compose
version: "3"
services:
  web:
    image: weibell/tiny404
    ports:
      - "10404:80"
```

## Optional environment variables

| Variable  | Default | Possible Values |
| - | - | - |
| STATUS_CODE  | 404  | 200, 401, 403, 404, 500 |

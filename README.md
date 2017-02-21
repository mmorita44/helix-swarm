Docker image of Helix Swarm.
=========================

[![licence badge]][licence]

# Build Details

- [Source Repository](https://github.com/mmorita44/helix-swarm)
- [Dockerfile](https://github.com/mmorita44/helix-swarm/blob/master/Dockerfile)

# Usage

Run docker image.

```
$ docker run -d -p 80:80 -p 443:443 -v mmorita44/helix-swarm:latest
```

Also run docker-compose.

```
version: '2'
services:
  helix-swarm:
    image: mmorita44/helix-swarm:latest
    ports:
      - 80:80
      - 443:443
    volumes:
      - data-helix-swarm:/opt/perforce/swarm/data

volumes:
  data-helix-swarm:
    driver: local
```


[licence]: <LICENSE>
[licence badge]: http://img.shields.io/badge/license-MIT-blue.svg?style=flat
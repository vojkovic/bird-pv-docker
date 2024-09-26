# bird-pv-docker

bird-pv-docker is a Docker image for the [BIRD Internet Routing Daemon](http://bird.network.cz/) with [Pathvector](https://pathvector.io/) support.

## Version

- BIRD: `pierky/bird:2.15`
- Pathvector: `pathvector:6.3.2`

## Usage

To run the container from the missuo/bird-pv image, use the following command:

```bash
docker run -d --name bird-pv --network host --restart always -v /path/to/pathvector.yml:/etc/pathvector.yml missuo/bird-pv
```

The container will run in the background and will use the host network stack. The Pathvector configuration file should be mounted to `/etc/pathvector.yml` in the container.

Docker compose example:

```yaml
services:
  bird:
    image: missuo/bird-pv
    network_mode: host
    restart: always
    volumes:
      - /path/to/pathvector.yml:/etc/pathvector.yml
```
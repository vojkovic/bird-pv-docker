# bird-pv-docker

bird-pv-docker is a Docker image for the [BIRD Internet Routing Daemon](http://bird.network.cz/) with [Pathvector](https://pathvector.io/). The image is based on the [Alpine Linux](https://alpinelinux.org/) distribution.


## Usage

To run the container from the build vojkovic/bird-pv image, use the following command:

```bash
docker run -d --name bird --network host --restart always -v /path/to/bird.conf:/etc/bird.conf vojkovic/bird-pv
```

The container will run in the background and will use the host network stack. The BIRD configuration file should be mounted to `/etc/bird.conf` in the container.

Docker compose example:

```yaml
services:
  bird:
    image: vojkovic/bird-pv
    network_mode: host
    restart: always
    volumes:
      - /path/to/bird.conf:/etc/bird.conf
```
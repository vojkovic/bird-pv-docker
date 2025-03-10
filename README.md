# bird-pv-docker

NOTICE: The default socket path for bird is `/run/bird.ctl`, you will need to set the `bird-socket` option in the Pathvector configuration file to `/run/bird.ctl` if you are using the default socket path.

i.e.

```yaml
bird-socket: /run/bird.ctl
```

bird-pv-docker is a Docker image for the [BIRD Internet Routing Daemon](http://bird.network.cz/) with [Pathvector](https://pathvector.io/) support. The image is based on the [Alpine Linux](https://alpinelinux.org/) distribution.

Also has [confetti](https://github.com/vojkovic/confetti) support for BGP monitoring.

## Usage

To run the container from the vojkovic/bird-pv image, use the following command:

```bash
docker run -d --name bird-pv --network host --restart always -v /path/to/pathvector.yml:/etc/pathvector.yml vojkovic/bird-pv
```

The container will run in the background and will use the host network stack. The Pathvector configuration file should be mounted to `/etc/pathvector.yml` in the container.

Docker compose example:

```yaml
services:
  bird:
    image: vojkovic/bird-pv
    network_mode: host
    restart: always
    volumes:
      - /path/to/pathvector.yml:/etc/pathvector.yml
```
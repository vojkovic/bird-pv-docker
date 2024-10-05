FROM alpine:latest

RUN apk add --no-cache bird

RUN bird # start bird in background to create /var/run/bird.ctl

ENV PATHVECTOR_VERSION=6.3.2

RUN wget https://github.com/natesales/pathvector/releases/download/v${PATHVECTOR_VERSION}/pathvector_${PATHVECTOR_VERSION}_linux_amd64.tar.gz && \
  tar -xvf pathvector_${PATHVECTOR_VERSION}_linux_amd64.tar.gz && \
  rm pathvector_${PATHVECTOR_VERSION}_linux_amd64.tar.gz && \
  rm -rf LICENSE README.md && \
  mv pathvector /usr/local/bin/pathvector && \
  mkdir -p /etc/bird && \
  chmod +x /usr/local/bin/pathvector

CMD ["pathvector", "-v", "-c", "/etc/pathvector.yml", "generate"]

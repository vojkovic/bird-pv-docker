FROM alpine:latest

ENV PATHVECTOR_VERSION=6.3.2

RUN apk add --no-cache bird && \
  mkdir -p /run/bird

RUN wget https://github.com/natesales/pathvector/releases/download/v${PATHVECTOR_VERSION}/pathvector_${PATHVECTOR_VERSION}_linux_amd64.tar.gz && \
  tar -xvf pathvector_${PATHVECTOR_VERSION}_linux_amd64.tar.gz && \
  rm pathvector_${PATHVECTOR_VERSION}_linux_amd64.tar.gz && \
  rm -rf LICENSE README.md && \
  mv pathvector /usr/local/bin/pathvector && \
  mkdir -p /etc/bird && \
  chmod +x /usr/local/bin/pathvector

CMD ["/bin/sh", "-c", "bird -c /etc/bird.conf -s /run/bird/bird.ctl & pathvector -v -c /etc/pathvector.yml generate && killall bird && bird -c /etc/bird/bird.conf -s /run/bird/bird.ctl -f"]

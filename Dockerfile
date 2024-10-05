FROM alpine:latest

RUN apk add --no-cache bird

# Start bird in the background to create /run/bird.ctl
# and ensure it runs in the foreground in a separate command
RUN bird -c /etc/bird.conf && \
  birdc configure

ENV PATHVECTOR_VERSION=6.3.2

RUN wget https://github.com/natesales/pathvector/releases/download/v${PATHVECTOR_VERSION}/pathvector_${PATHVECTOR_VERSION}_linux_amd64.tar.gz && \
  tar -xvf pathvector_${PATHVECTOR_VERSION}_linux_amd64.tar.gz && \
  rm pathvector_${PATHVECTOR_VERSION}_linux_amd64.tar.gz && \
  rm -rf LICENSE README.md && \
  mv pathvector /usr/local/bin/pathvector && \
  mkdir -p /etc/bird && \
  chmod +x /usr/local/bin/pathvector

CMD ["pathvector", "-v", "-c", "/etc/pathvector.yml", "generate"]

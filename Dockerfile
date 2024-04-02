FROM alpine:latest

RUN apk add --no-cache bird

RUN export PATHVECTOR_VERSION=6.3.2

RUN wget https://github.com/natesales/pathvector/releases/download/v${PATHVECTOR_VERSION}/pathvector_${PATHVECTOR_VERSION}_linux_amd64.tar.gz
RUN tar -xvf pathvector_${PATHVECTOR_VERSION}_linux_amd64.tar.gz
RUN rm pathvector_${PATHVECTOR_VERSION}_linux_amd64.tar.gz
RUN rm -rf LICENSE README.md

RUN mv pathvector /usr/local/bin/pathvector
RUN chmod +x /usr/local/bin/pathvector

CMD ["bird", "-f", "-c", "/etc/bird.conf"]
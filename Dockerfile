FROM alpine:latest

FROM node:18-alpine AS deps

RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY caramel/package.json caramel/yarn.lock ./
RUN yarn install --frozen-lockfile

FROM node:18-alpine AS builder

WORKDIR /app

COPY caramel/ ./

COPY --from=deps /app/node_modules ./node_modules

RUN yarn build

ENV PATHVECTOR_VERSION=6.3.2

RUN wget https://github.com/natesales/pathvector/releases/download/v${PATHVECTOR_VERSION}/pathvector_${PATHVECTOR_VERSION}_linux_amd64.tar.gz && \
  tar -xvf pathvector_${PATHVECTOR_VERSION}_linux_amd64.tar.gz && \
  chmod +x pathvector

FROM node:18-alpine AS runner

WORKDIR /usr/app

COPY --from=builder /app/build ./build

COPY --from=builder /app/pathvector /usr/bin/pathvector

COPY ./caramel/package.json .

RUN yarn

RUN apk update && apk add --no-cache bird mtr tcptraceroute

USER node

ENV NODE_ENV="production"

CMD ["/bin/sh", "-c", "bird -c /etc/bird.conf && pathvector -v -c /etc/pathvector.yml generate && killall bird && bird -c /etc/bird/bird.conf && node build/index.js"]

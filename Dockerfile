FROM alpine:latest as dependencies

ENV NODE_VERSION=20.11.1

RUN apk add --no-cache \
    nodejs npm python3 sqlite make gcc g++ libc-dev

COPY package.json .

RUN npm install --verbose

FROM alpine:latest

LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.docker.cmd="docker run -d -p 3000:3000 --name alpine_timeoff"

RUN apk add --no-cache \
    nodejs npm \
    vim

RUN adduser --system app --home /app
USER app
WORKDIR /app
COPY . /app
COPY --from=dependencies node_modules ./node_modules

CMD npm start

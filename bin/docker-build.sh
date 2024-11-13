#!/bin/sh
set -e

# shellcheck disable=SC1091
. ./release.env

cp target/hello*.jar .
docker build . -f deploy/docker/Dockerfile \
  -t siakhooi/hello-springboot-microservice:latest \
  -t siakhooi/hello-springboot-microservice:"$DOCKER_VERSION"

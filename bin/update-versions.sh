#!/bin/sh
set -e

. ./release.env

mvn versions:set -DnewVersion="$MAVEN_JAR_VERSION"

sed -i 'deploy/docker/Dockerfile'  -e 's@ARG APP_VERSION=.*@ARG APP_VERSION='"$MAVEN_JAR_VERSION"'@g'

sed -i 'deploy/docker/Dockerfile'  -e 's@ARG LABEL version=.*@LABEL version='"$DOCKER_VERSION"'@g'

sed -i 'deploy/helm/hello-springboot-microservice/Chart.yaml' -e 's@appVersion:.*@appVersion: "'"$MAVEN_JAR_VERSION"'"@g'

sed -i 'deploy/helm/hello-springboot-microservice/Chart.yaml' -e 's@version:.*@version: '"$HELM_CHART_VERSION"'@g'

sed -i 'deploy/helm/hello-springboot-microservice/values.yaml' -e 's@    tag:.*@    tag: "'"$DOCKER_VERSION"'"@g'
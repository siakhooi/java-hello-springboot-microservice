FROM eclipse-temurin:21-jre-alpine
MAINTAINER Siak Hooi, Ng
LABEL org.opencontainers.image.authors="Siak Hooi, Ng"
LABEL org.opencontainers.image.vendor="Siak Hooi, Ng"
LABEL org.opencontainers.image.url=https://hub.docker.com/r/siakhooi/hello-springboot-microservice
LABEL org.opencontainers.image.documentation=https://github.com/siakhooi/java-hello-springboot-microservice
LABEL org.opencontainers.image.source=https://github.com/siakhooi/java-hello-springboot-microservice
LABEL org.opencontainers.image.title=java-hello-springboot-microservice
LABEL org.opencontainers.image.description="POC/template repo for Springboot Microservice"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.base.name=eclipse-temurin:21.0.2_13-jre-alpine
LABEL org.opencontainers.image.base.digest=sha256:d3e9b76faa33518bedb6f8dbe979c6fdf80892da33eb571957e650cb3d67a93e
LABEL org.opencontainers.image.version=0.20.0
LABEL org.opencontainers.image.revision=0.31.0
LABEL org.opencontainers.image.created="2025-05-28 07:39:26.214078125+00:00"

ARG APP_VERSION=0.10.0
ARG JAR_NAME=hellospringbootmicroservice

EXPOSE 8080

COPY --chown=root:root --chmod=644 ${JAR_NAME}-${APP_VERSION}.jar ${JAR_NAME}.jar

RUN addgroup -g 10001 group00 && adduser -D -u 10002 user00 group00
USER user00:group00

ENTRYPOINT ["java","-jar","/${JAR_NAME}.jar"]

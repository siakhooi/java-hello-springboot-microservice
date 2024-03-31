FROM eclipse-temurin:21.0.2_13-jre-alpine
MAINTAINER "Siak Hooi"
LABEL author="Siak Hooi"
LABEL version=0.6.0
LABEL release-date="2024-03-29"

ENV APP_VERSION=0.5.0
EXPOSE 8080

COPY --chown=root:root --chmod=644 hellospringbootmicroservice-${APP_VERSION}.jar hellospringbootmicroservice-${APP_VERSION}.jar

RUN addgroup -g 10001 group00 && adduser -D -u 10002 user00 group00
USER user00:group00

ENTRYPOINT ["java","-jar","/hellospringbootmicroservice-0.5.0.jar"]

spring-init-hello-springboot-microservice:
	spring init --java-version 17 \
	  --group-id 'sing.app' \
	  --artifact-id 'hellospringbootmicroservice' \
	  --package-name 'sing.app.hellospringbootmicroservice' \
	  --version '1.0.0' \
	  --name "Hello Spring Boot Microservice" \
	  --description 'Hello Spring Boot Microservice' \
	  --type  maven-project \
	  -d=web \
	  --extract

java17:
	sdk install java 17.0.10-amzn
build:
	mvn clean verify
clean:
	mvn clean
run:
	mvn spring-boot:run

setversion:
	mvn versions:set -DnewVersion=0.2.0

create-release:
	gh release create 0.2.0 --title 'add actuator' --notes "add actuator" --latest

docker-build:
	docker build . -f deploy/docker/Dockerfile -t siakhooi/hello-springboot-microservice:latest

docker-run:
	docker run --rm -p 8080:8080 siakhooi/hello-springboot-microservice:latest 

curl:
	curl http://localhost:8080/greeting

curl-actuator:
	curl http://localhost:8080/actuator |jq
curl-actuator-health:
	curl http://localhost:8080/actuator/health
curl-actuator-shutdown:
	curl -X POST http://localhost:8080/actuator/shutdown
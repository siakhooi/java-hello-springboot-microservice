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

build:
	mvn verify

run:
	mvn spring-boot:run

setversion:
	mvn versions:set -DnewVersion=0.1.0

create-release:
	gh release create 0.1.0 --title 'initial release' --notes "initial release" --latest

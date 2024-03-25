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

java21:
	sdk install java 21.0.2-tem  
build:
	mvn clean verify
clean:
	mvn clean
run:
	mvn spring-boot:run
test:
	mvn test
setversion:
	mvn versions:set -DnewVersion=0.3.0

create-release:
	gh release create 0.4.0 --title 'helm add label' --notes "helm add label\nhelm 0.3.0 docker 0.3.0 jar 0.3.0" --latest
create-release-1:
	gh release create 0.2.1 --title 'add helm chart' --notes "add helm chart" --latest
delete-release:
	gh release delete --cleanup-tag 0.2.0
docker-build:
	docker build . -f deploy/docker/Dockerfile -t siakhooi/hello-springboot-microservice:latest
docker-run:
	docker run --rm -p 8080:8080 siakhooi/hello-springboot-microservice:latest 

curl:
	curl http://localhost:8080/greeting
curl-earth:
	curl http://localhost:8080/greeting?name=Earth
curl-actuator:
	curl --no-progress-meter  http://localhost:8080/actuator |jq
curl-actuator-health:
	curl http://localhost:8080/actuator/health
curl-actuator-shutdown:
	curl -X POST http://localhost:8080/actuator/shutdown

helm-create:
	mkdir -p deploy/helm
	cd deploy/helm
	helm create hello-springboot-microservice

helm-build:
	helm lint deploy/helm/hello-springboot-microservice/
	helm template  hello-springboot-release-1  deploy/helm/hello-springboot-microservice/
	helm package   deploy/helm/hello-springboot-microservice/ 

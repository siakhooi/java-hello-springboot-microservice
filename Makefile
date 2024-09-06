verify-all: setversion build docker-build helm-build
git-push:
	bin/git-commit-and-push.sh
create-release:
	bin/create-release.sh
git-watch:
	gh run watch
	gh run list
	gh run rerun --failed

setversion:
	bin/update-versions.sh

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
	mvn clean verify
clean:
	mvn clean
	rm hello-springboot-microservice-*.tgz hello-springboot-release-1.chart.yaml hellospringbootmicroservice-*.jar

run:
	mvn spring-boot:run
run-moon:
	java -jar -Dapp.defaultGreetingMessage=Moon target/hellospringbootmicroservice-0.6.0.jar
run-jupiter:
	app_defaultGreetingMessage=Jupiter java -jar target/hellospringbootmicroservice-0.6.0.jar

test:
	mvn test
dv:
	mvn versions:display-dependency-updates

delete-release:
	gh release delete --cleanup-tag 0.25.0
docker-build:
	bin/docker-build.sh
docker-run:
	docker run --rm -p 8080:8080 siakhooi/hello-springboot-microservice:latest
docker-run-uranus:
	docker run --rm -p 8080:8080 -e app_defaultGreetingMessage=Uranus siakhooi/hello-springboot-microservice:latest
docker-run-base:
	docker run -it --rm eclipse-temurin:21.0.2_13-jre-alpine sh
docker-inspect:
	docker inspect siakhooi/hello-springboot-microservice:latest
docker-get-base-digest:
	docker inspect eclipse-temurin:21.0.2_13-jre-alpine | jq -r '.[].Id'
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

helm-lint:
	helm lint deploy/helm/hello-springboot-microservice/
helm-template:
	helm template  hello-springboot-release-1  deploy/helm/hello-springboot-microservice/ --debug | tee hello-springboot-release-1.chart.yaml
helm-package:
	helm package   deploy/helm/hello-springboot-microservice/
helm-build: helm-lint helm-template helm-package

helm-reinstall: helm-uninstall zootopia-load-image helm-install
helm-uninstall:
	shed-helm uninstall hello1
helm-install: zootopia-load-image
	shed-helm install hello1 ./hello-springboot-microservice-0.24.0.tgz

k-pf:
	shed-kubectl port-forward service/hello1-hello-springboot-microservice 8080:80
k-create-configmap:
	k create configmap hello-spring-boot-microservice --from-literal=app.defaultGreetingMessage=Wakanda
k-get-cm:
	shed-kubectl get cm/hello-springboot-microservice -o yaml
k-edit-cm:
	shed-kubectl edit cm/hello-springboot-microservice

zootopia-load-image:
	zootopia-load-docker-images siakhooi/hello-springboot-microservice:0.18.0

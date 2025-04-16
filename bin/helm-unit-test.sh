#!/bin/sh

set -ex

readonly output_file="${PWD}/helm-unit-test.xml"

cd deploy/helm
helm unittest hello-springboot-microservice --output-file "$output_file"

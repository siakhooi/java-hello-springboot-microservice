#!/bin/sh
set -e

PATH_TO_FILE=$(ls ./hello-springboot-microservice-*.tgz)
HELM_CHART_SOURCE_PATH=$(realpath "$PATH_TO_FILE")
HELM_CHART_PACKAGE_FILE=$(basename "$PATH_TO_FILE")

TMPDIR=$(mktemp -d)

TARGETPATH=docs/hello-springboot-microservice
TARGETURL=https://${PUBLISH_TO_GITHUB_HELM_CHARTS_TOKEN}@github.com/siakhooi/helm-charts.git
TARGETBRANCH=main
TARGETDIR=helm-charts-repo
TARGET_GIT_EMAIL=hello-springboot-microservice@siakhooi.github.io
TARGET_GIT_USERNAME=shello-springboot-microservice
TARGET_COMMIT_MESSAGE="hello-springboot-microservice: Auto deploy [$(date)]"

(
  cd "$TMPDIR"
  git config --global user.email "$TARGET_GIT_EMAIL"
  git config --global user.name "$TARGET_GIT_USERNAME"

  git clone -n --depth=1 -b "$TARGETBRANCH" "$TARGETURL" "$TARGETDIR"
  cd "$TARGETDIR"
  git remote set-url origin "$TARGETURL"
  git restore --staged .
  mkdir -p $TARGETPATH
  cp -v -f "$HELM_CHART_SOURCE_PATH" "$TARGETPATH/$HELM_CHART_PACKAGE_FILE"
  git add "$TARGETPATH/$HELM_CHART_PACKAGE_FILE"
  git status
  git commit -m "$TARGET_COMMIT_MESSAGE"
  git push
)
find .

#!/bin/bash

cd `dirname $0`
source VERSION
SCRIPT_DIR="`pwd`"

PACKAGE_NAME=android
PACKAGE_DIR="`pwd`/_package/$PACKAGE_NAME"

set -ex

IMAGE_NAME=webrtc/$PACKAGE_NAME:m${WEBRTC_VERSION}
DOCKER_BUILDKIT=1 docker build \
  -t $IMAGE_NAME \
  -f $PACKAGE_NAME/Dockerfile \
  --build-arg COMMIT_HASH="$WEBRTC_COMMIT" \
  .

mkdir -p $PACKAGE_DIR
CONTAINER_ID=`docker container create -i -t --name webrtc-container $IMAGE_NAME`
docker container cp $CONTAINER_ID:/webrtc.tar.gz ../
docker container rm $CONTAINER_ID
docker rmi -f $IMAGE_NAME

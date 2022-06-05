#!/bin/sh

REPO_NAME=nuttyapps
IMG_NAME=nuttyapps-front
IMG_PATH=registry.gitlab.com/jesus.zini/nuttyapps/front:latest

# start...
cd ../${IMG_NAME}

# docker image prune -af
docker build -t="${IMG_NAME}" .

# get just created image ID
IMG_ID=$(docker images --format "{{.ID}} {{.Repository}}" | grep ${IMG_NAME} | awk '{ print $1 }')

docker tag ${IMG_ID} ${IMG_PATH}

docker push ${IMG_PATH}

cd ../${REPO_NAME}
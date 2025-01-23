#!/bin/bash
image_name="my-app"
tag="latest"
docker build -t $image_name:$tag .
docker tag $image_name:$tag my-docker-repo/$image_name:$tag
docker push my-docker-repo/$image_name:$tag
echo "Docker image pushed: my-docker-repo/$image_name:$tag
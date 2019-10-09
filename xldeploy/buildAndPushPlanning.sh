#!/bin/bash
REPOTAG=xl-deploy:9.0.5-centos-debug-planning
docker rmi -f docker.io/brokerme/$REPOTAG
docker build . -t docker.io/brokerme/$REPOTAG --no-cache -f Dockerfile-Planning
loginToDockerRegistryBrokerme.sh 
docker push  docker.io/brokerme/$REPOTAG


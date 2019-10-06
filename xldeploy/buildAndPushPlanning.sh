#!/bin/bash
REPOTAG=xl-deploy:9.0.5-centos-debug-planning
docker build . -t docker.io/brokerme/$REPOTAG -f Dockerfile-Planning
loginToDockerRegistryBrokerme.sh 
docker push  docker.io/brokerme/$REPOTAG


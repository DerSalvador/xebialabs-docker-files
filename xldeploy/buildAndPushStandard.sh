#!/bin/bash
REPOTAG=xl-deploy:9.0.5-centos-debug-standard
docker build . -t docker.io/brokerme/$REPOTAG -f Dockerfile-Standard
loginToDockerRegistryBrokerme.sh 
docker push  docker.io/brokerme/$REPOTAG


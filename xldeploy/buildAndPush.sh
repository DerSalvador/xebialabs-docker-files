#!/bin/bash
REPOTAG=xl-deploy:debug
docker build . -t docker.io/brokerme/$REPOTAG
loginToDockerRegistryBrokerme.sh 
docker push  docker.io/brokerme/$REPOTAG


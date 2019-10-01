#!/bin/bash
REPOTAG=xl-deploy:9.0.5-centos-debug
docker build . -t docker.io/brokerme/$REPOTAG
loginToDockerRegistryBrokerme.sh 
docker push  docker.io/brokerme/$REPOTAG


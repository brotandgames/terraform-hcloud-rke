#!/usr/bin/env bash

self=${0##*/}
echo "== $self Waiting 20 sec. for package managers ..."
sleep 20

DOCKER_VERSION="$1"

echo "== $self Install Docker ${DOCKER_VERSION}"
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
sudo apt-get update
sudo apt list docker-ce -a
# sudo apt-get install -y docker-ce=${DOCKER_VERSION}~ce~3-0~ubuntu-$(lsb_release -cs)
sudo apt-get install -y docker-ce=${DOCKER_VERSION}~ce~3-0~ubuntu

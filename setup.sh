#!/bin/bash
#setup.sh

# Install docker-compose:
sudo apt update && sudo apt install docker-compose -y

# create a new test network(ip: 172.19.0.0/16):
docker network create --driver=bridge test-net

# run demo containers in the background:
docker-compose up -d && echo done...

# Copy war service file into Tomcat:
docker cp warfiles/SOAP_Customer.war customers:/app



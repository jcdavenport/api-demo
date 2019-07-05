#!/bin/bash
#setup.sh

# Install docker-compose:
sudo apt update && sudo apt install -y docker-compose 

sudo apt install -y docker-compose --fix-missing

# change owner permissions for warfiles:
sudo chown 1001:root warfiles/* && sudo chmod 644 warfiles/*

# run demo containers in the background:
docker-compose up -d && sleep 5

# Copy war service file into Tomcat:
docker cp warfiles/SOAP_Customer.war customers:/app
docker cp warfiles/SOAP_Product.war products:/app

echo done...

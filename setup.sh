#!/bin/bash
#setup.sh

# Install docker-compose:
sudo apt update && sudo apt install -y docker-compose 

sudo apt install -y docker-compose --fix-missing

# change owner permissions for warfiles:
sudo chown 1001:root warfiles/* && sudo chmod 644 warfiles/*

#change owner permissions for gateway config file:
sudo chown root:root gateway_config/gateway.config.yml
sudo chmod 644 gateway_config/gateway.config.yml

# run demo containers in the background:
docker-compose up -d && sleep 5

# Copy war service file into Tomcat:
docker cp warfiles/SOAP_Customer.war customers:/app
docker cp warfiles/SOAP_Product.war products:/app
docker cp warfiles/SOAP_Client.war client:/var/lib/jetty/webapps

docker restart customers

docker restart products

echo done...
echo "Client is at http://127.0.0.1:8008"
echo "Read instructions.txt to configure gateway" 
echo "and set endpoints!"

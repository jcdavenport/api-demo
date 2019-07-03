#Setting up the demo

-> run demo containers in the background:
$ docker-compose up -d



-> create a new test network(ip: 172.19.0.0/16):	
$ docker network create --driver=bridge test-net



-> create a database for the service(docker cli):
(using mysql-admin console container)
$ docker run -it --rm \
--name mysql-admin \
--network test-net \
mysql mysql -h172.19.0.2 -uroot -p

(on the admin console)
	mysql> CREATE DATABASE customer;
			  
	mysql> ctrl + d


-> Copy war service file into Tomcat:
$ docker cp warfiles/SOAP_Customer.war customers:/app


-> access shell within node container and create guts:
$ docker exec -it gateway /bin/bash
	# mkdir /opt/gateway 	
	# npm install -g express-gateway
	# eg gateway create


-> change ownership of config file and start gateway:
        $ docker exec -it gateway /bin/bash
        # cd /opt/gateway/config
        # chown root:root gateway.config.yml
		# chmod 644 gateway.config.yml
        # cd ..
        # node .
        # ctrl+z (pauses server)
        # bg     (resumes server in background)
        # ctrl+d (close connection while server continues to run)
        
		(Endpoint: http://localhost:8080/api/customer)


*** The following is run on your localhost OS ***
-> Run the client on the localhost and connect to the backend services:

    a. run client on Tomcat through Eclipse IDE on localhost:8080
	    'http://localhost:8080/SOAP_Client/sampleCustomerPortProxy/TestClient.jsp'
    
    b. set Endpoint to the
        'http://localhost:8080/api/customer'
		
	c. try adding a customer and getAllCustomers to see if it's using the service through the gateway.




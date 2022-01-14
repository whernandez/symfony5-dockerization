Mariadb
=======

Simple Mariadb setup

##### Requirements

1. Port `3306` should be available for the container

##### Installation  

1. Clone this repository

2. Copy .env.sample to .env or echo the value.

    ```bash
    $ echo "MYSQL_ROOT_PASSWORD=database-password" > .env	 
    ```
    
3. Start the services

    ```bash
    $ cd mariadb
    $ docker-compose up -d --build
    ```	
	
4. Mariadb will be available on port `3306`


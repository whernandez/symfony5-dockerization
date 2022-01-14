> This project contains the necessary resources to dockerize a symfony application using tools such as:
nginx (Web server), traefik (HTTP Proxy), mariadb (database), PHP8 (language), docker (platform to containerize the app)

## Requirements: Docker and docker-compose

The project is structured as follows:

1. data: Volume used by application (optional)

2. spool: Volume used by application (optional)

3. nginx: Web Server dockerization

4. php80: Dockerization of php8.0

5. mariadb: Database dockerization

6. traefik: Trafik dockerization

7. .dockerignore: Prevent files from being added to the initial build context.

8. .env.dist: Environment variables

9. docker-compose.yml.dist: Contains the services that will be containerized by docker.

10. Makefile: Contains the list of aliases for docker and application commands.

11. README.md: Documentation

> The Makefile file will help us with the commands we need to carry out the installation of the application, but before we start, we are going to upload the services and the database.

## Traefik:

```cd traefik```

Install and upload the image and the container of Traefik

```docker-compose up -d --build```

## Mariadb:

```cd mariadb```

Install and upload the image and database container

## Setting the environment variable.

```nano .env```

# Application
```
APP_NAME=symfony

APP_HOST=api.symfony.local

APP_ENV=dev

# Database

DATABASE_HOST=172.17.0.1

DATABASE_NAME=symfony

DATABASE_PASSWORD=your.custom.password

DATABASE_USER=root

DATABASE_PORT=3306

# Traefik

TRAEFIK_HOST_API_01=api.symfony.local

# network name

DOCKER_NETWORK=docker_default
```

## Let's start installing the app

With the following command you will create the docker network, copy the environment variable and copy the docker-compose.yml configuration, create the php and nginx images, upload the web server and php containers

```make build```

Create symfony application from php container

```make app-create```

The application has been created in a directory with the name we gave the app, in this case it is located in ./app/symphony540_test.
What we must do is move the app to the main directory, which would be ./app

## Setup the App

Get into the container
```make ssh-be```

Move the app files
```mv symphony540_test/* .```
```mv symphony540_test/.env .```
```mv symphony540_test/.gitignore .```

Remove directory symphony540_test
```rm -rf symphony540_test```

Register in the operating system host the host name that we gave to the app in traefik, this name was set in the environment variable.
In this case it is api.symfony.local

After set the hostname, then, go to your browser and type: http://api.symfony.local

If all is OK, you should see the Symfony 5.4 welcome page.
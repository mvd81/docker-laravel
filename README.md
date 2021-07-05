# docker-laravel
Setup Laravel with Docker-compose, with

* Nginx
* Mysql
* Node JS
* Composer
* Redis

# How to use this

Create a directory where you want to use this Docker project.  
Go with the CLI to this folder.  
```
git clone git@github.com:mvd81/docker-laravel.git .
rm -r .git --force
mkdir src
```

## Change Docker config.
Change the docker-compose / dockerfile (update network name, ports, etc)

## Start Docker
```docker-compose up -d --build```

## Install laravel
```composer create-project --prefer-dist laravel/laravel src```

## Update .env
Update the .env config based on the settings (ports / db credentials) from your docker-compose.yml file.

## Installation wizard?
Use an installation wizard to setup Laravel with Docker.  
https://github.com/mvd81/new-docker-laravel-project-wizard


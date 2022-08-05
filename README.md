# Docker Laravel

This repo will help you to setup a fresh docker-compose file and it will install the latest version of Laravel with the help of an installation (shell script) wizard.  
What it will do:
* The wizard will ask you some questions and will generate the docker-compose file for you
* Installation of the latest Laravel version
* Update the .env file from the wizard answers
* Add config for Vite
* Starting the Docker containers
* Shows you information how to use Vite in development + the database credentials
* Ask if you want to open the project in your browser (Chrome / Firefox)
* Removes the .git directory, installation stubs and installation wizard

----

# Usage

Create a directory where you want to use this Docker Laravel project.  
Go to CLI into this directory.

* Clone this repo: ```git clone git@github.com:mvd81/docker-laravel.git .```
* Run the installation wizard: ```sh install.sh```


----

# Screenshots

#### Screenshot 1
<img alt="Installation wizard" src="stubs/wizard-1.png" width="" />

#### Screenshot 2
<img alt="Project information after the installation" src="stubs/wizard-2.png" width="" />

-----

# Docker-compose containers

* Nginx
* PHP
* Mysql
* Node JS
* Composer
* Redis
* PHPmyadmin (optional)

----

# Next feature

Add an option in the installation wizard to install / setup 
* Tailwind
* Vue js
* Alpine js

----

# Changelog

## [v2.0] - 2022-08-03

* Add an installation wizard, which makes it even easier to setup a Laravel project with Docker (you don't have to manually change the docker-compose file, run the command to install Laravel, start the containers and open the project in your browser)
* Update docker-compose for the latest Laravel installation
* Config for Vite
* Add the function (optional) to add PHPmyadmin

## [v1.0] - 2022-03-02
* docker-compose template file


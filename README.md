# Docker Laravel

<img alt="header image" src="stubs/docker-laravel-header.png" width="" />

This repo will help you to setup a Docker project and it will (optionally) install the latest version of Laravel with the help of an installation (shell script) wizard.  
What it will do:
* The wizard will ask you some questions and then it will generate the Docker files for you
* Starting the Docker containers
* Installation of the latest Laravel version (optional)
* * Update the .env file from the wizard answers
* * Add config for Vite
* * Ask if you want to install assets (VueJS / Tailwind / AlpineJS) + the setup config files for them + a blade demo file
* * Shows you information how to use Vite for development + the database credentials information
* * Ask if you want to open the project in your browser (Chrome / Firefox)
* Removes the .git directory, .gitignore, installation stubs and installation wizard

----

# Usage

Create a directory where you want to use this Docker Laravel project.  
Go with the CLI into this directory.

* Clone this repo: ```git clone git@github.com:mvd81/docker-laravel.git .```
* Make the 'src' direcory: ```mkdir src```
* Run the installation wizard: ```bash install.sh```


----

# Screenshots

#### Port config
<img alt="Installation wizard" src="stubs/wizard-1.png" width="" />

#### Asset installation
<img alt="Asset installation" src="stubs/wizard-3.png" width="" />

#### Project information after the installation
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

# Changelog

## [v2.3] - 2022-11-25
Fixes for Linux:
* Create a user in the Docker file to prevent creating new files as root user
* Changes in the installation wizard
* Don't run composer as root user

## [v2.2] - 2022-10-20

* Fix .env settings (correct settings for DB_HOST and DB_PASSWORD)
* Fix when removing the .git directory, .gitignore, installation stubs and installation wizard when you don't want to install Laravel (wrong path)

## [v2.1] - 2022-08-17

* Add option to install assets (Vue JS / Tailwind / AlpineJS) 

## [v2.0] - 2022-08-03

* Add an installation wizard, which makes it even easier to setup a Laravel project with Docker (you don't have to manually change the docker-compose file, run the command to install Laravel, start the containers and open the project in your browser)
* Update docker-compose for the latest Laravel installation
* Config for Vite
* Add the function (optional) to add PHPmyadmin

## [v1.0] - 2022-03-02
* docker-compose template file


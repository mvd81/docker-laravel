# docker-laravel
My Docker with Laravel starters setup

# How to use this

Create a directory where you want to use this Docker project.  
Go with the CLI to this folder.  
```
git clone git@github.com:mvd81/docker-laravel.git .
rm -r .git --force
mkdir src
```

## Change docker config.
Change the docker-compose / dockerfile

## Start Docker
```docker-compose up -d --build```

## Install laravel
```composer create-project --prefer-dist laravel/laravel src```

## Update .env
Update the .env config based on the settings (ports / db credentials) form your docker-compose.yml file.



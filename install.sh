#!/bin/bash
echo""
echo "Welcome to the Docker Laravel installation"
echo ""

RED='\033[0;31m'

# Check if the src folder exists, if we create the dir in this script with 'mkdir' the folder has root permission
if [ ! -d "./src" ]; then
  echo -e "${RED}src directory does not exist, create this directory first: mkdir src"
  exit 1;
fi

# CONFIG ###############################################################################################################

# Rename project
read -p "Your project name (don't use special chars or spaces): " project_name

if [ $project_name != "" -a $project_name != "" ]; then
sed -i "s/project_name/$project_name/" docker-compose.yml
sed -i "s/projectname/$project_name/" docker-compose.yml
sed -i "s/laravel_app/$project_name/" docker-compose.yml
sed -i "s/test_name_db/test_$project_name/" sql_scripts/create_test_db.sql
fi

# Nginx port
read -p "A free Ngnix port number (leave empty to use 80 as default): " nginx_port
if [ $nginx_port != "" -a $nginx_port != "" ]; then
sed -i "s/80:80/$nginx_port:80/" docker-compose.yml
sed -i "s/port: 80/port: $nginx_port/" stubs/vite.config.js
fi

# PHP port
read -p "A free PHP port number (leave empty to use 9000 as default): " php_port
if [ $php_port != "" -a $php_port != "" ]; then
sed -i "s/9000:9000/$php_port:9000/" docker-compose.yml
fi

# Mysql port
read -p "A free Mysql port number (leave empty to use 3306 as default): " mysql_port
if [ $mysql_port != "" -a $mysql_port != "" ]; then
sed -i "s/3306:3306/$mysql_port:3306/" docker-compose.yml
fi

# Redis port
read -p "A free Redis port number (leave empty to use 6379 as default): " redis_port
if [ $redis_port != "" -a $redis_port != "" ]; then
sed -i "s/6379:6379/$redis_port:6379/" docker-compose.yml
fi

# Vite port
read -p "A free Vite port number (leave empty to use 5173 as default): " vite_port
if [ $vite_port != "" -a $vite_port != "" ]; then
sed -i "s/port: 5173/port: $vite_port/" stubs/vite.config.js
sed -i "s/port: 5173/port: $vite_port/" stubs/vite_vue.config.js
fi

# PHPmyadmin
read -p "Do you want to use PHPmyadmin? If so, give a free port number or leave empty to not to add PHPmyadmin: " phpmyadmin_port
if [ $phpmyadmin_port != "" -a $phpmyadmin_port != "" ]; then
echo "" >> docker-compose.yml
echo "" >> docker-compose.yml
echo "  phpmyadmin:" >> docker-compose.yml
echo "    image: phpmyadmin" >> docker-compose.yml
echo "    restart: always" >> docker-compose.yml
echo "    ports:" >> docker-compose.yml
echo "      - $phpmyadmin_port:80" >> docker-compose.yml
echo "    environment:" >> docker-compose.yml
echo "      PMA_HOST: mysql" >> docker-compose.yml
echo "    networks:" >> docker-compose.yml
echo "      - $project_name" >> docker-compose.yml
fi

# Startup containers
echo "Starting the containers..."
docker-compose up -d --build > /dev/null

# INSTALL LARAVEL ######################################################################################################

read -p "Install the latest Laravel version (yes/no): " install_laravel
if [ $install_laravel != "" -a $install_laravel = "yes" -o $install_laravel = "y"  ]; then

  cd src

  echo ""
  echo "Download and installing the latest Laravel version....this may take a while so get some coffee"
  echo ""
  docker-compose run composer create-project --prefer-dist laravel/laravel .
  docker-compose run composer composer require predis/predis

  # Update the .env file
  sed -i "s/localhost/localhost:$nginx_port/" .env
  sed -i "s/DB_DATABASE=laravel/DB_DATABASE=$project_name/" .env
  sed -i "s/DB_HOST=127.0.0.1/DB_HOST=mysql/" .env
  sed -i "s/DB_PASSWORD=/DB_PASSWORD=secret456/" .env
  sed -i "/REDIS_HOST=127.0.0.1/d" .env
  sed -i "/REDIS_PASSWORD=null/d" .env
  sed -i "/REDIS_PORT=6379/d" .env

  echo "" >> .env
  echo "CACHE_DRIVER=redis" >> .env
  echo "REDIS_CLIENT=predis" >> .env
  echo "REDIS_HOST=redis" >> .env
  echo "REDIS_PASSWORD=null" >> .env
  echo "REDIS_PORT=6379" >> .env

  echo "" >> .env
  echo "TEST_DB_CONNECTION=mysql" >> .env
  echo "TEST_DB_HOST=mysql" >> .env
  echo "test_DB_PORT=3306" >> .env
  echo "TEST_DB_DATABASE=test_$project_name" >> .env
  echo "TEST_DB_USERNAME=root" >> .env
  echo "TEST_DB_PASSWORD=secret456" >> .env

  # Copy the changed config stubs.
  cp ../stubs/vite.config.js vite.config.js
  cp ../stubs/config/database.php config/database.php
  cp ../stubs/phpunit.xml phpunit.xml

  # Install some assets
  PS3='Do you want install some bundle assets? '
  options=("No thanks" "Yes, Vue" "Yes, Vue + Tailwind" "Yes, Vue + Tailwind + Alpinejs")
  select opt in "${options[@]}"
  do
      case $opt in
          "No thanks")
              break
              ;;
          "Yes, Vue")

              echo ""
              echo "One moment, downloading the NPM package + creating config file"
              echo ""
              docker-compose run npm i @vitejs/plugin-vue
              cp ../stubs/vite_vue.config.js vite.config.js
              cp ../stubs/app_vue.js resources/js/app.js
              cp ../stubs/App.vue resources/js/App.vue
              cp ../stubs/vite.blade.php resources/views/vite.blade.php
              echo "Check 'src/resources/views/vite.blade.php' how load JS and CSS with Vite in Blade"
              break
              ;;
          "Yes, Vue + Tailwind")

              echo ""
              echo "One moment, downloading the NPM packages + creating config file"
              echo ""
              docker-compose run npm i @vitejs/plugin-vue
              docker-compose run npm install -D tailwindcss postcss autoprefixer
              cp ../stubs/vite_vue.config.js vite.config.js
              cp ../stubs/app_vue.js resources/js/app.js
              cp ../stubs/tailwind.css resources/css/app.css
              cp ../stubs/tailwind.config.js tailwind.config.js
              cp ../stubs/postcss.config.js postcss.config.js
              cp ../stubs/App.vue resources/js/App.vue

              # Copy example over welcome.blade.php
              cp resources/views/welcome.blade.php resources/views/welcome.blade.php.bak
              cp ../stubs/vite_tailwind.blade.php resources/views/welcome.blade.php

              # Compile assets
              docker-compose -f ../docker-compose.yml run --publish $vite_port:$vite_port npm run build

              break
             ;;
          "Yes, Vue + Tailwind + Alpinejs")

              echo ""
              echo "One moment, downloading the NPM packages + creating config file"
              echo ""
              docker-compose run npm i @vitejs/plugin-vue
              docker-compose run npm install -D tailwindcss postcss autoprefixer
              docker-compose run npm i alpinejs

              cp ../stubs/vite_vue.config.js vite.config.js
              cp ../stubs/app_vue_alpine.js resources/js/app.js
              cp ../stubs/tailwind.css resources/css/app.css
              cp ../stubs/tailwind.config.js tailwind.config.js
              cp ../stubs/postcss.config.js postcss.config.js
              cp ../stubs/App.vue resources/js/App.vue

              # Copy example over welcome.blade.php
              cp resources/views/welcome.blade.php resources/views/welcome.blade.php.bak
              cp ../stubs/vite_tailwind_alpine.blade.php resources/views/welcome.blade.php

              # Compile assets
              docker-compose -f ../docker-compose.yml run --publish $vite_port:$vite_port npm run build

              break
              ;;
          *) echo "invalid option $REPLY";;
      esac
  done

  # Remove stubs folder + this installation script.
  rm -f ../install.sh
  rm -rf ../stubs
  rm -rf ../.git
  rm -f ../.gitignore

  # Clear the readme
  : > README.md

  echo ""
  echo "************** PROJECT INFO ***********************************************************************************"
  echo ""
  echo "DB credentials:"
  echo "Host: localhost"
  echo "User: root"
  echo "Password: secret456"
  echo "Port: $mysql_port"
  echo ""
  echo ""

  # NPM info

  echo "Vite:"
  echo "Run 'docker-compose -f docker-compose.yml run --publish $vite_port:$vite_port npm run dev' to run Vite in development"
  echo "Check 'src/resources/views/vite.php' how load JS and CSS with Vite in Blade"
  echo ""
  echo "***************************************************************************************************************"

  # Aks to open the project in the browser
  PS3='Do you want to open this project in your browser now? '
  options=("No thanks" "Yes in Firefox" "Yes in Chrome")
  select opt in "${options[@]}"
  do
      case $opt in
          "No thanks")
              echo "Installation done :)"
              break
              ;;
          "Yes in Firefox")
              start firefox -new-tab "http://localhost:$nginx_port"
              if [ $phpmyadmin_port != "" -a $phpmyadmin_port != "" ]; then
                start firefox -new-tab "http://localhost:$phpmyadmin_port"
              fi
              echo "Installation done :)"
              break
              ;;
          "Yes in Chrome")
              start chrome -new-tab "http://localhost:$nginx_port"
               if [ $phpmyadmin_port != "" -a $phpmyadmin_port != "" ]; then
                start chrome -new-tab "http://localhost:$phpmyadmin_port"
              fi
              echo "Installation done :)"
              break
              ;;
          *) echo "invalid option $REPLY";;
      esac
  done

else

  # Remove stubs folder + this installation script.
  rm -f install.sh
  rm -rf stubs
  rm -rf .git
  rm -f .gitignore

  # Clear the readme
  : > README.md
  echo "Docker files created"
  echo "Project in the browser: http://localhost:$nginx_port"

fi
echo""
echo "Welcome to the Docker Laravel installation"
echo ""

# CONFIG ###############################################################################################################

# Nginx port
read -p "A free Ngnix port number (leave empty to use 80 as default): " nginx_port
if [[ $nginx_port != "" && $nginx_port != "" ]]; then
sed -i "s/80:80/$nginx_port:80/" docker-compose.yml
fi

# PHP port
read -p "A free PHP port number (leave empty to use 9000 as default): " php_port
if [[ $php_port != "" && $php_port != "" ]]; then
sed -i "s/9000:9000/$php_port:9000/" docker-compose.yml
fi

# Mysql port
read -p "A free Mysql port number (leave empty to use 3306 as default): " mysql_port
if [[ $mysql_port != "" && $mysql_port != "" ]]; then
sed -i "s/3306:3306/$mysql_port:3306/" docker-compose.yml
fi

# Redis port
read -p "A free Redis port number (leave empty to use 6379 as default): " redis_port
if [[ $redis_port != "" && $redis_port != "" ]]; then
sed -i "s/6379:6379/$redis_port:6379/" docker-compose.yml
fi

# PHPmyadmin
read -p "Do you want to use PHPmyadmin? If so, give a free port number or leave empty to not to add PHPmyadmin: " phpmyadmin_port
if [[ $phpmyadmin_port != "" && $phpmyadmin_port != "" ]]; then
sed -i "s/8080:80/$phpmyadmin_port:80/" docker-compose.yml
sed -i "s/endphpmyadminservice//" docker-compose.yml
sed -i "s/phpmyadminservice//" docker-compose.yml
else
  sed -i "/phpmyadminservice/,/endphpmyadminservice/d" docker-compose.yml
fi

# INSTALL LARAVEL ######################################################################################################

# Startup containers
docker-compose up -d --build > /dev/null

read -p "Install the latest Laravel version (yes/no): " install_laravel
if [[ $install_laravel != "" && $install_laravel == "yes" ]]; then

  mkdir src
  cd src

  echo ""
  echo "Download and installing the latest Laravel version....may take a while"
  echo ""
  docker-compose run composer create-project --prefer-dist laravel/laravel .
  docker-compose run composer composer require predis/predis

  # Update the .env file
  sed -i "s/localhost/localhost:$nginx_port/" .env

  # Open the browser
  start firefox -new-tab "http://localhost:$nginx_port"

fi
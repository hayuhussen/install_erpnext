#!/bin/bash

# Server Settings: Update and Upgrade Packages
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Required Packages
# Install GIT
sudo apt-get install git -y

# Install Python Dependencies
sudo apt-get install python3-dev -y
sudo apt-get install python3-setuptools python3-pip -y
sudo apt install python3.12-venv -y

# Install MariaDB
sudo apt-get install software-properties-common -y
sudo apt install mariadb-server -y
sudo mysql_secure_installation

# Edit MYSQL default config file
sudo bash -c 'cat >> /etc/mysql/my.cnf <<EOF
[mysqld]
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci
[mysql]
default-character-set = utf8mb4
EOF'
sudo service mysql restart

# Install Redis Server
sudo apt-get install redis-server -y

# Install CURL, Node, NPM and Yarn
sudo apt install curl -y
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.profile
nvm install 18
sudo apt-get install npm -y
sudo npm install -g yarn -y

# Install wkhtmltopdf
sudo apt-get install xvfb libfontconfig wkhtmltopdf -y

# Install Frappe Bench
sudo -H pip3 install frappe-bench --break-system-packages
sudo -H pip3 install ansible --break-system-packages

# Initialize Frappe Bench
bench init frappe-bench --frappe-branch version-15
cd frappe-bench
chmod -R o+rx ./

# Create a New Site
read -p "Enter site name: " SITE_NAME
bench new-site $SITE_NAME

# Install ERPNext and other Apps
bench get-app payments
bench get-app --branch version-15 erpnext
bench --site $SITE_NAME install-app erpnext

# Optional: Install other apps
read -p "Do you want to install additional apps (e.g., hrms)? [y/n]: " INSTALL_APPS
if [ "$INSTALL_APPS" == "y" ]; then
  read -p "Enter app name: " APP_NAME
  bench get-app $APP_NAME
  bench --site $SITE_NAME install-app $APP_NAME
fi

# Start the Server
bench start

# Production Setup
read -p "Enable production mode? [y/n]: " ENABLE_PRODUCTION
if [ "$ENABLE_PRODUCTION" == "y" ]; then
  bench --site $SITE_NAME enable-scheduler
  bench --site $SITE_NAME set-maintenance-mode off
  sudo bench setup production $(whoami)
  bench setup nginx
  sudo supervisorctl restart all
  sudo bench setup production $(whoami)
fi

# Add site to hosts
bench --site $SITE_NAME add-to-hosts

# Completion Message
if [ "$ENABLE_PRODUCTION" == "y" ]; then
  echo "ERPNext setup is complete! Access your site at: http://$SITE_NAME"
else
  echo "ERPNext setup is complete! Access your site in development mode at: http://$SITE_NAME:8000"
fi

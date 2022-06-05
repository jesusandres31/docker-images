#!/bin/sh

echo "Stopping apache..."
sudo systemctl stop apache2.service

echo "Stopping api..."
sudo systemctl stop timetracker-api.service

echo "Insert bitbucket username (you must have access to the timetracker repository!): "
read BITBUCKET_USERNAME

cd api/
echo "About to pull api..."
sudo git pull https://${BITBUCKET_USERNAME}@bitbucket.org/devlightsok/devlights.timetracker.api.git/ master

cd ../front
echo "About to pull front..."
sudo git pull https://${BITBUCKET_USERNAME}@bitbucket.org/devlightsok/devlights.timetracker.frontend.git/ master

echo "About to build react app..."
sudo npm run build

cd ..
echo "Resarting api..."
sudo systemctl restart timetracker-api.service
sudo systemctl status timetracker-api.service

echo "Resarting apache..."
sudo systemctl restart apache2.service
sudo systemctl status apache2.service

echo " "
echo " "
echo " "
echo "Done!"
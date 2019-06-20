#!/bin/bash
cd /home/osmc
sudo apt-get update 2>&1 | dialog --title "Updating package database and installing needed .deb packages..." --infobox "\nPlease wait...\n" 11 70 
if [ ! -d /usr/share/doc/python-crypto ]; then
	sudo apt-get install -q python-crypto
fi
sudo apt-get install -q -y build-essential python-pip libnss3 libnspr4

dialog --title "Installing python dependencies..." --infobox "\nPlease wait...\n" 11 70
sudo pip install -q -U setuptools
sudo pip install -q wheel
sudo pip install -q pycryptodomex==3.8.2

mkdir addons
cd addons
dialog --title "Downloading Netflix add-on" --infobox "\nPlease wait...\n" 11 70
wget -q https://github.com/CastagnaIT/plugin.video.netflix/archive/master.zip
if [ -f "./plugin.video.netflix.zip" ]; then
      mv plugin.video.netflix.zip plugin.video.netflix.zip.old
fi
mv master.zip  plugin.video.netflix.zip

sudo systemctl stop mediacenter
sleep 5
dialog --title "Installation finnished!" --msgbox "\nThank you for using my installer\nNow go to addon-browsser and choose install from zip\nNavigate to homefolder/addons and install netflix plugin." 11 70
sudo systemctl start mediacenter


#!/bin/bash
#Set UTF-8; e.g. "en_US.UTF-8" or "de_DE.UTF-8":
export LC_ALL="en_US.UTF-8"

#Tell ncurses to use line characters that work with UTF-8.
export NCURSES_NO_UTF8_ACS=1

cd /home/osmc
sudo apt-get update 2>&1 | dialog --title "Updating package database and installing needed .deb packages..." --infobox "\nPlease wait...\n" 11 70 
if [ ! -d /usr/share/doc/python-crypto ]; then
	sudo apt-get install -q python-crypto
fi
sudo apt-get install -q -y build-essential python-pip libnss3 libnspr4

dialog --title "Installing python dependencies..." --infobox "\nPlease wait...\n" 11 70
sudo pip install -q -U setuptools
sudo pip install -q wheel
sudo pip install -q pycryptodomex

mkdir addons
cd addons
dialog --title "Downloading Netflix add-on" --infobox "\nPlease wait...\n" 11 70
wget -q https://github.com/CastagnaIT/plugin.video.netflix/archive/master.zip
## Just keeping two versions of the add-on
if [ -f "./plugin.video.netflix.zip" ]; then
	if [ -f "./plugin.video.netflix.zip.old" ]; then
		rm plugin.video.netflix.zip.old
	fi
	mv plugin.video.netflix.zip plugin.video.netflix.zip.old
fi
mv master.zip  plugin.video.netflix.zip

sudo systemctl stop mediacenter
sleep 5
dialog --title "Installation finished!" --msgbox "\nThank you for using my installer\nNow go to addon-browser and choose install from zip\nNavigate to homefolder/addons and install Netflix plugin." 11 70
if [ -f "/home/osmc/netflix_prep_install.sh" ]; then
	rm /home/osmc/netflix_prep_install.sh
fi	
sudo systemctl start mediacenter


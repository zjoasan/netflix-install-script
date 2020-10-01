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

if [ ! -d "/home/osmc/addons" ]; then
	mkdir addons
fi
cd addons
dialog --title "Downloading Netflix repository" --infobox "\nPlease wait...\n" 11 70
wget -q -O netflix-repo.zip https://github.com/castagnait/repository.castagnait/raw/master/repository.castagnait-1.0.1.zip
#for Matrix use this wget 
# wget -q -O netflix-repo.zip https://github.com/castagnait/repository.castagnait/raw/matrix/repository.castagnait-1.0.0.zip
## Just keeping two versions of the add-on
if [ -f "./netflix-repo.zip" ]; then
	if [ -f "./netflix-repo.zip.old" ]; then
		rm netflix-repo.zip.old
	fi
	mv netflix-repo.zip netflix-repo.zip.old
	
fi

#from a rasbian problem solution for extracting the widevine libary, dont know if it's a OSMC issue though, don't se a real security issue, but you do as you please with this line, worked before without it in OSMC
sudo echo 'osmc ALL=NOPASSWD:/bin/mount,/bin/umount,/sbin/losetup,/sbin/modprobe"' >> /etc/sudoers

sudo systemctl stop mediacenter
sleep 5
dialog --title "Installation finnished!" --msgbox "\nThank you for using my installer\nNow go to addon-browsser and choose install from zip\nNavigate to homefolder/addons and install netflix repository." 11 70
if [ -f "/home/osmc/netflix_prep_install.sh" ]; then
	rm /home/osmc/netflix_prep_install.sh
fi	
sudo systemctl start mediacenter


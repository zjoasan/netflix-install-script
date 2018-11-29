#!/bin/bash
cd /home/osmc
sudo apt-get update 2>&1 | dialog --title "Updating package database and installing needed .deb packages..." --infobox "\nPlease wait...\n" 11 70 
if [ ! -d /usr/share/doc/python-crypto ]; then
	sudo apt-get install -q python-crypto
fi
sudo apt-get install -q -y build-essential python-pip zip

dialog --title "Installing python dependencies..." --infobox "\nPlease wait...\n" 11 70
sudo pip install -q -U setuptools
sudo pip install -q wheel
sudo pip install -q pycryptodomex==3.7.0

mkdir addons
cd addons
dialog --title "Downloading Netflix add-on and dependencies" --infobox "\nPlease wait...\n" 11 70
wget -q https://github.com/asciidisco/plugin.video.netflix/archive/msl2.zip
mv msl2.zip  plugin.video.netflix.zip
wget -q http://ftp.fau.de/osmc/osmc/download/kodi/addons/leia/script.module.certifi/script.module.certifi-2017.07.27.1.zip
wget -q http://ftp.fau.de/osmc/osmc/download/kodi/addons/leia/script.module.chardet/script.module.chardet-3.0.4.zip
wget -q http://ftp.fau.de/osmc/osmc/download/kodi/addons/leia/script.module.idna/script.module.idna-2.6.zip
wget -q http://ftp.fau.de/osmc/osmc/download/kodi/addons/leia/script.module.urllib3/script.module.urllib3-1.22.zip
wget -q http://ftp.fau.de/osmc/osmc/download/kodi/addons/leia/script.module.requests/script.module.requests-2.19.1.zip
wget -q http://ftp.fau.de/osmc/osmc/download/kodi/addons/leia/script.module.inputstreamhelper/script.module.inputstreamhelper-0.3.3.zip
wget -q http://ftp.fau.de/osmc/osmc/download/kodi/addons/leia/script.module.addon.signals/script.module.addon.signals-0.0.3.zip

sudo systemctl stop mediacenter
dialog --title "Installing dependencies..." --infobox "\nPlease wait...\n" 11 70
sleep 5

unzip -o -q -d /home/osmc/.kodi/addons/ script.module.certifi-2017.07.27.1.zip
unzip -o -q -d /home/osmc/.kodi/addons/ script.module.chardet-3.0.4.zip
unzip -o -q -d /home/osmc/.kodi/addons/ script.module.idna-2.6.zip
unzip -o -q -d /home/osmc/.kodi/addons/ script.module.urllib3-1.22.zip
unzip -o -q -d /home/osmc/.kodi/addons/ script.module.requests-2.19.1.zip
unzip -o -q -d /home/osmc/.kodi/addons/ script.module.inputstreamhelper-0.3.3.zip
unzip -o -q -d /home/osmc/.kodi/addons/ script.module.addon.signals-0.0.3.zip
#unzip netflix addon to add a few lines
#unzip  -q plugin.video.netflix.zip
#cd plugin.video.netflix-master/resources/lib/
#sed -i.bak '/# Video/i\#PRK Profile\n"hevc-main10-L30-dash-cenc-prk",' ./MSL.py
#cd ../../..
#rm plugin.video.netflix.zip
#zip -r plugin.video.netflix.zip plugin.video.netflix-master/


rm script*.zip
dialog --title "Installation finnished!" --msgbox "\nThank you for using my installer\nNow go to addon-browsser and choose install from zip\nNavigate to homefolder/addons and install netflix plugin." 11 70
sudo systemctl start mediacenter


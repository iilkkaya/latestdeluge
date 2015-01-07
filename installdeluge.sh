#Install Deluge
clear
echo -ne "Enter Deluge Port [30000]:"
read delugeport
killall deluge deluge-web
initctl emit deluge-stop
dpkg --purge remove deluge
dpkg --purge remove deluged
apt-get --purge remove deluge
apt-get --purge remove deluged
rmdir -r /opt/deluge/
rmdir -r /usr/src/deluge-1.3.6
rmdir -r /usr/src/deluge-1.3.7
rmdir -r /usr/src/deluge-1.3.8
rmdir -r /usr/src/deluge-1.3.9
rmdir -r /usr/src/deluge-1.3.10
userdel -r deluge
apt-get update
aptitude install python python-twisted python-twisted-web2 python-openssl \
python-simplejson python-setuptools gettext python-xdg python-chardet \
python-geoip python-libtorrent python-notify python-pygame python-gtk2 \
python-gtk2-dev librsvg2-dev xdg-utils python-mako
cd /usr/src
wget http://download.deluge-torrent.org/source/deluge-1.3.6.tar.gz
tar xfz deluge-1.3.6.tar.gz
rm deluge-1.3.6.tar.gz
cd deluge-1.3.6
python setup.py clean -a
python setup.py build
python setup.py install
adduser --disabled-password --system --home /home/deluge --group deluge

rm /etc/init/deluge-web.conf
touch /etc/init/deluge-web.conf
echo "description \"deluge-web starter\"" >> /etc/init/deluge-web.conf
echo "start on (local-filesystems" >> /etc/init/deluge-web.conf
echo "and runlevel [2345]) or deluge-start" >> /etc/init/deluge-web.conf
echo "stop on runlevel [016] or deluge-stop" >> /etc/init/deluge-web.conf
echo "respawn" >> /etc/init/deluge-web.conf
echo "exec start-stop-daemon --start --chuid deluge --user deluge \\" >> /etc/init/deluge-web.conf
echo "--exec /usr/local/bin/deluge-web -- -p $delugeport" >> /etc/init/deluge-web.conf

rm /etc/init/deluged.conf
touch /etc/init/deluged.conf
echo "description \"deluge-web starter\"" >> /etc/init/deluged.conf
echo "start on (local-filesystems" >> /etc/init/deluged.conf
echo "and runlevel [2345]) or deluge-start" >> /etc/init/deluged.conf
echo "stop on runlevel [016] or deluge-stop" >> /etc/init/deluged.conf
echo "respawn" >> /etc/init/deluged.conf
echo "exec start-stop-daemon --start --chuid deluge --user deluge \\" >> /etc/init/deluged.conf
echo "--exec /usr/local/bin/deluged -- -d" >> /etc/init/deluged.conf

initctl emit deluge-start
cd
rm installdeluge.sh
#clear
echo "Deluge Interface: http://HOSTNAME:$delugeport/ Password: Deluge"

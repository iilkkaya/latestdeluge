#Fix Turkish Characters
sudo wget https://raw.githubusercontent.com/iilkkaya/latestdeluge/master/km-041f.ini
sudo cp km-041f.ini /etx/xrdp/
sudo chown root:root /etc/xrdp/km-041f.ini
sudo /etc/init.d/xrdp restart
echo "Tamamdýr kankeee"
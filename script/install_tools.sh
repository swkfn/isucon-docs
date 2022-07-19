#!/bin/bash
#ref: https://github.com/k-nasa/isucon-magic-powder/blob/master/bootstrap

ALP=1.0.10
PT=3.4.0

echo 'Installing alp'
wget https://github.com/tkuchiki/alp/releases/download/v$ALP/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
sudo mv alp /usr/bin/
rm -rf alp*

echo 'Install pt-query-digest'
wget https://github.com/percona/percona-toolkit/archive/$PT.tar.gz
tar zxvf $PT.tar.gz
sudo mv ./percona-toolkit-$PT/bin/pt-query-digest /usr/bin/
rm $PT.tar.gz
rm -rf percona-toolkit-$PT

echo 'netdata'
bash <(curl -Ss https://my-netdata.io/kickstart.sh)
sudo systemctl start netdata

echo 'dstat'
sudo apt install -y dstat

echo 'htop'
sudo apt install -y htop

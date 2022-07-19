#!/bin/bash
#ref: https://github.com/k-nasa/isucon-magic-powder/blob/master/bootstrap

ALP=1.0.10
KT=0.4.3
PT=3.4.0

echo 'Install unzip'
sudo apt install -y unzip

echo 'Install alp'
wget https://github.com/tkuchiki/alp/releases/download/v$ALP/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
sudo mv alp /usr/bin/
rm -rf alp*

echo 'Install Kataribe'
mkdir kataribe
cd kataribe
wget https://github.com/matsuu/kataribe/releases/download/v$KT/kataribe-v$KT_linux_amd64.zip
unzip kataribe-v$KT_linux_amd64.zip
sudo mv kataribe /usr/bin
cd ..
rm -rf kataribe

echo 'Install pt-query-digest'
wget https://github.com/percona/percona-toolkit/archive/$PT.tar.gz
tar zxvf $PT.tar.gz
sudo mv ./percona-toolkit-$PT/bin/pt-query-digest /usr/bin/
rm $PT.tar.gz
rm -rf percona-toolkit-$PT

echo 'Install netdata'
bash <(curl -Ss https://my-netdata.io/kickstart.sh)
sudo systemctl start netdata

echo 'Install dstat'
sudo apt install -y dstat

echo 'Install htop'
sudo apt install -y htop

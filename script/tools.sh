#ref: https://github.com/k-nasa/isucon-magic-powder/blob/master/bootstrap
echo 'Installing alp'
wget https://github.com/tkuchiki/alp/releases/download/v1.0.7/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
sudo mv alp /usr/bin/

rm alp_linux_amd64.zip

echo 'Install pt-query-digest'
wget https://github.com/percona/percona-toolkit/archive/3.0.5-test.tar.gz
tar zxvf 3.0.5-test.tar.gz
sudo mv ./percona-toolkit-3.0.5-test/bin/pt-query-digest /usr/bin/

rm 3.0.5-test.tar.gz
rm -rf percona-toolkit-3.0.5-test
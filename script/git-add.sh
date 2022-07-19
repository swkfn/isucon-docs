#!/bin/bash

# 設定ファイル・ソースコードを Git 管理する

HIS="/home/isucon"

# backup
sudo cp -r /etc /etc-backup
sudo cp -r $HIS/webapp $HIS/webapp-backup

# cp
sudo cp -r /etc $(pwd)/etc
sudo cp -r $HIS/webapp $(pwd)/webapp

# symblik

sudo ln -sb $(pwd)/etc /etc
sudo ln -sb $(pwd)/webapp $HIS/webapp

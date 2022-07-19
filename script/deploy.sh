#!/bin/bash
# ref: https://github.com/k-nasa/isucon-magic-powder/blob/master/deploy
warn() {
  printf "[\033[00;33mWARN\033[0m] $1\n"
}

BRANCH=$1
warn "Please implement $0"

echo "cd /home/isucon && \
git stash && \
git checkout $BRANCH && \
git pull origin $BRANCH && \
make bench"

cd /home/isucon && \
git stash && \
git checkout $BRANCH && \
git pull origin $BRANCH && \
make bench
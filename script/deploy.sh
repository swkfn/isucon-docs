#!/bin/bash
# ref: https://github.com/k-nasa/isucon-magic-powder/blob/master/deploy
BRANCH=$1

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
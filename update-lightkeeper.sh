#!/usr/bin/env bash

set -e

if [ -z "$1" ]
  then
    echo "Missing version. Expects a tag, e.g. './update-lightkeeper.sh v9.6.6'"
    exit 1
fi

git remote add upstream https://github.com/GoogleChrome/lighthouse.git || true
git fetch upstream
git switch lightkeeper
git pull
git checkout --detach
git rebase --onto $1 cbabcf4217dfa5da6ad083f666fcd074c18a00c9~1
sudo yarn
sudo yarn build-all
shopt -s extglob
rm -rf -- ../lightkeeper/frontend/lighthouse/viewer/!(README.md)
mv dist/gh-pages/viewer/* ../lightkeeper/frontend/lighthouse/viewer/
git switch lightkeeper

#!/usr/bin/env bash

if [ -z "$1" ]
  then
    echo "Missing version. Expects a tag, e.g. './update-lightkeeper.sh v9.6.6'"
    exit 1
fi

git remote add upstream https://github.com/GoogleChrome/lighthouse.git || true
git fetch upstream
git switch lightkeeper
git merge $1
git push
yarn
yarn build-viewer
shopt -s extglob
rm -rf -- ../lightkeeper/frontend/lighthouse/viewer/!(README.md)
mv dist/gh-pages/viewer/* ../lightkeeper/frontend/lighthouse/viewer/

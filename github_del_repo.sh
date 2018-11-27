#! /bin/sh

#for calling from symbolic link
if [ -L $0 ]; then
  COMMAND_DIR=$(dirname `readlink $0`)
else
  COMMAND_DIR="."
fi
. $COMMAND_DIR/settings.conf
. $COMMAND_DIR/lib/github_curl.sh
GITHUB_API_URL="https://api.github.com"

if [ -z $USER ]; then
  echo "\nUSER is not found. Please set the value at settings.conf. \n" 1>&2
  exit 1
fi

if [ -z $1 ]; then
  echo "\nUsage: github_del_repo project_name \n" 1>&2
  exit 1
fi

PROJECT_NAME=$1

github_curl -X DELETE $GITHUB_API_URL/repos/$USER/$PROJECT_NAME

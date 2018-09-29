#! /bin/sh

. ./lib/github_curl.sh
GITHUB_API_URL="https://api.github.com"

while getopts u:p: OPT
do
  case $OPT in
    u)  GITHUB_USER=$OPTARG
        ;;
    p)  PROJECT_NAME=$OPTARG
        ;;
    \?) echo "\nUsage: github_del_repo [ -u user ] [ -p project_name ]\n" 1>&2
        exit 1
        ;;
  esac
done

if [ -z $GITHUB_USER ]; then
  echo "\nUsage: github_del_repo [ -u user ] [ -p project_name ]\n" 1>&2
  exit 1
fi

if [ -z $PROJECT_NAME ]; then
  echo "\nUsage: github_del_repo [ -u user ] [ -p project_name ]\n" 1>&2
  exit 1
fi

github_curl -X DELETE $GITHUB_API_URL/repos/$GITHUB_USER/$PROJECT_NAME

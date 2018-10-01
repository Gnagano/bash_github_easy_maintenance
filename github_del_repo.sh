#! /bin/sh

. ./lib/github_curl.sh
GITHUB_API_URL="https://api.github.com"

while getopts u: OPT
do
  case $OPT in
    u)  GITHUB_USER=$OPTARG
        ;;
    \?) echo "\nUsage: github_del_repo [ -u user ] [ project_name ]\n" 1>&2
        exit 1
        ;;
  esac
done

shift $((OPTIND - 1))

if [ -z $GITHUB_USER ]; then
  echo "\nUsage: github_del_repo [ -u user ] [ project_name ]\n" 1>&2
  exit 1
fi

if [ -z $1 ]; then
  echo "\nUsage: github_del_repo [ -u user ] [ project_name ]\n" 1>&2
  exit 1
fi

PROJECT_NAME=$1

github_curl -X DELETE $GITHUB_API_URL/repos/$GITHUB_USER/$PROJECT_NAME

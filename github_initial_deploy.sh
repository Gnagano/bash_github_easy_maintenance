#! /bin/sh
. settings.conf
. ./lib/github_curl.sh

if [ -z $1 ]; then
  echo  "\nUsage: github_inital_deploy [ project_name ]\n" 1>&2
  exit 1
fi

PROJECT_NAME=$1

# create repository
github_curl -X POST $GITHUB_API_URL/user/repos -d '{"name":"'$PROJECT_NAME'","private":"true"}'

# generate ssh key
sh ./github_keygen.sh -C $KEY_COMMENT $PROJECT_NAME

# deploy ssh key
cat $ACCESS_TOKEN | xargs -I {} curl -H "Authorization: token {}" -H 'Content-Type:application/json' -X POST $GITHUB_API_URL/repos/$USER/$PROJECT_NAME/keys -d '{ "title" : "'$KEY_TITLE'","key" : "'"$(cat $HOME/.ssh/github_keys/$PROJECT_NAME.pub)"'" }'

# set the origin
git remote add origin git@$PROJECT_NAME:$USER/$PROJECT_NAME.git

# git push
git push origin --all

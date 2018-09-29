#! /bin/sh
USER="gano2018"
ACCESS_TOKEN="$HOME/.github/github_token"
PROJECT_NAME="test092901"
GITHUB_API_URL="https://api.github.com"
KEY_COMMENT="gen.nagano.cc20120701@gmail.com"
KEY_ID=1
KEY_TITLE="gano@iMac"

github_curl (){
  cat $ACCESS_TOKEN | xargs -I {} curl -H "Authorization: token {}" -H 'Content-Type:application/json' $@
}

# create repository
github_curl -X POST $GITHUB_API_URL/user/repos -d '{"name":"'$PROJECT_NAME'","private":"true"}'

# delete repository
# github_curl -X DELETE $GITHUB_API_URL/repos/$USER/$PROJECT_NAME

# generate ssh key
github_keygen -C $KEY_COMMENT $PROJECT_NAME

# deploy ssh key
cat $ACCESS_TOKEN | xargs -I {} curl -H "Authorization: token {}" -H 'Content-Type:application/json' -X POST $GITHUB_API_URL/repos/$USER/$PROJECT_NAME/keys -d '{ "title" : "'$KEY_TITLE'","key" : "'"$(cat $HOME/.ssh/github_keys/$PROJECT_NAME.pub)"'" }'

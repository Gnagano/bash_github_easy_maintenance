#! /bin/sh
. settings.conf

github_curl (){
  cat $ACCESS_TOKEN | xargs -I {} curl -H "Authorization: token {}" -H 'Content-Type:application/json' $@
}

# create repository
github_curl -X POST $GITHUB_API_URL/user/repos -d '{"name":"'$PROJECT_NAME'","private":"true"}'

# delete repository
#github_curl -X DELETE $GITHUB_API_URL/repos/$USER/$PROJECT_NAME

# generate ssh key
github_keygen -C $KEY_COMMENT $PROJECT_NAME

# deploy ssh key
cat $ACCESS_TOKEN | xargs -I {} curl -H "Authorization: token {}" -H 'Content-Type:application/json' -X POST $GITHUB_API_URL/repos/$USER/$PROJECT_NAME/keys -d '{ "title" : "'$KEY_TITLE'","key" : "'"$(cat $HOME/.ssh/github_keys/$PROJECT_NAME.pub)"'" }'

# set the origin
git remote add origin git@$PROJECT_NAME:$USER/$PROJECT_NAME.git

# git push
git push origin --all

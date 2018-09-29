#! /bin/sh

USER="gano2018"
ACCESS_TOKEN="$HOME/.github/github_token"
PROJECT_NAME="test092901"

#curl https://api.github.com/users/$USER/repos
#cat $ACCESS_TOKEN | xargs -I {} curl -H "Authorization: token {}" https:/api.github.com/user/repos

#curl -X POST [url] -d "name=hoge&age=20"
cat $ACCESS_TOKEN | xargs -I {} curl -H "Authorization: token {}" -H 'Content-Type:application/json' -X POST https://api.github.com/user/repos -d '{"name":"test092901"}'

#DELETE repository
#cat $ACCESS_TOKEN | xargs -I {} curl -H "Authorization: token {}" -X DELETE https://api.github.com/repos/$USER/$PROJECT_NAME

#! /bin/sh
USER="gano2018"
ACCESS_TOKEN="$HOME/.github/github_token"
PROJECT_NAME="test092901"

github_curl (){
  cat $ACCESS_TOKEN | xargs -I {} curl -H "Authorization: token {}" -H 'Content-Type:application/json' $@
}

github_curl -X POST https://api.github.com/user/repos -d '{"name":"'$PROJECT_NAME'"}'
github_curl -X DELETE https://api.github.com/repos/$USER/$PROJECT_NAME

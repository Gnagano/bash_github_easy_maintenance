#! /bin/sh
USER="gano2018"
ACCESS_TOKEN="$HOME/.github/github_token"
PROJECT_NAME="test092901"
GITHUB_API_URL="https://api.github.com"

github_curl (){
  cat $ACCESS_TOKEN | xargs -I {} curl -H "Authorization: token {}" -H 'Content-Type:application/json' $@
}

github_curl -X POST $GITHUB_API_URL/user/repos -d '{"name":"'$PROJECT_NAME'","private":"true"}'
#github_curl -X DELETE $GITHUB_API_URL/repos/$USER/$PROJECT_NAME

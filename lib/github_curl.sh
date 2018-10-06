#! /bin/sh
ACCESS_TOKEN="$HOME/.github/github_token"

github_curl (){
  cat $ACCESS_TOKEN | xargs -I {} curl -H "Authorization: token {}" -H 'Content-Type:application/json' $@
}

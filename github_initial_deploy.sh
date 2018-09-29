#! /bin/sh

USER="gano2018"
ACCESS_TOKEN="$HOME/.github/github_token"

#curl https://api.github.com/users/$USER/repos
cat $ACCESS_TOKEN | xargs -I {} curl -H "Authorization: token {}" https:/api.github.com

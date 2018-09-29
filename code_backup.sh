#curl https://api.github.com/users/$USER/repos
#cat $ACCESS_TOKEN | xargs -I {} curl -H "Authorization: token {}" https:/api.github.com/user/repos

#curl -X POST [url] -d "name=hoge&age=20"
#cat $ACCESS_TOKEN | xargs -I {} curl -H "Authorization: token {}" -H 'Content-Type:application/json' -X POST https://api.github.com/user/repos -d '{"name":"'$PROJECT_NAME'"}'

#DELETE repository
#cat $ACCESS_TOKEN | xargs -I {} curl -H "Authorization: token {}" -X DELETE https://api.github.com/repos/$USER/$PROJECT_NAME



# github_repository_exists (){
#   repos=$(github_curl $GITHUB_API_URL/user/repos | jq .[].name)
#
#   #echo 1
#   for i in ${repos[@]}
#   do
#     if [ ${repos[$i]} = $1 ]; then
#       echo 0
#     fi
#   done
#   echo 1
#   # if echo " ${repos[*]} " | grep -q " $1 " ; then
#   #   return 1
#   # fi
#   # return 0
# }
#echo $(github_repository_exists)
#
# if [ `echo $(github_repository_exists "first_pr")` -eq 0 ]; then
#   echo "true dayo"
# else
#   echo "false dayo"
# fi
#

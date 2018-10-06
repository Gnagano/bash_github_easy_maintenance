#! /bin/sh
. settings.conf

# Exit if $1 is exit
if [ -z $1 ]; then
  echo  "\nUsage: github_inital_clone [ project_name ]\n" 1>&2
  exit 1
fi

PROJECT_NAME=$1

# generate ssh key
sh ./github_keygen.sh -C $KEY_COMMENT $PROJECT_NAME

# Exit if key has already existed
if [ $? != 0 ]; then
  exit 1
fi

# 2. deploy key

# deploy ssh key
cat $ACCESS_TOKEN | xargs -I {} curl -H "Authorization: token {}" -H 'Content-Type:application/json' -X POST $GITHUB_API_URL/repos/$USER/$PROJECT_NAME/keys -d '{ "title" : "'$KEY_TITLE'","key" : "'"$(cat $HOME/.ssh/github_keys/$PROJECT_NAME.pub)"'" }'

# 3. git remote origin add
git remote add origin git@$PROJECT_NAME:$USER/$PROJECT_NAME.git

# 4. git fetch origin
git fetch origin

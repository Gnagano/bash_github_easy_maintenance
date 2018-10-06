#! /bin/sh

#for calling from symbolic link
if [ -L $0 ]; then
  COMMAND_DIR=$(dirname `readlink $0`)
else
  COMMAND_DIR="."
fi
. $COMMAND_DIR/settings.conf

# Exit if $1 is exit
if [ -z $1 ]; then
  echo  "\n[Error] The way to use command is not correct.\n Usage: github_inital_clone [ project_name ]\n" 1>&2
  exit 1
fi

PROJECT_NAME=$1

# Exit if current directory include .git
if [ -d `pwd`/.git ]; then
  echo  "\n[Error] The current directory has been already git repository.\n" 1>&2
  exit 1
fi

# Exit if directory PROJECT_NAME is existed
if [ -d `pwd`/$PROJECT_NAME ]; then
  echo  "\n[Error] git repository has been already cloned.\n" 1>&2
  exit 1
fi

# generate ssh key
sh $COMMAND_DIR/github_keygen.sh -C $KEY_COMMENT $PROJECT_NAME

# Exit if key has already existed
#if [ $? != 0 ]; then
#  exit 1
#fi

# deploy ssh key
cat $ACCESS_TOKEN | xargs -I {} curl -H "Authorization: token {}" -H 'Content-Type:application/json' -X POST $GITHUB_API_URL/repos/$USER/$PROJECT_NAME/keys -d '{ "title" : "'$KEY_TITLE'","key" : "'"$(cat $HOME/.ssh/github_keys/$PROJECT_NAME.pub)"'" }'

# 3. git remote origin add
git clone git@$PROJECT_NAME:$USER/$PROJECT_NAME.git

# 4. git fetch origin
cd $PROJECT_NAME
git fetch origin

#! /bin/sh
COMMENT="default"

# option
while getopts C: OPT
do
  case $OPT in
    C)  COMMENT=$OPTARG
        ;;
    \?) echo "\nUsage: github_keygen [-C comment] project\n" 1>&2
        exit 1
        ;;
  esac
done
shift `expr $OPTIND - 1`

# Exit if project is null
if [ -z $1 ]; then
  echo "\nUsage: github_keygen [-C comment] project\n" 1>&2
  exit 1
fi

# Exit if the same name key exists
if [ -f $HOME/.ssh/github_keys/$1.pub ]; then
  echo "\n[ERROR] The key for the project '$1' has already exists.\n"
  exit 1
fi

# mkfit keys dir if doesn't exist
if [ ! -e  $HOME/.ssh/github_keys ]; then
  mkdir $HOME/.ssh/github_keys
fi

# generate rsa key
ssh-keygen -t rsa -b 4096 -C "$COMMENT" -f $HOME/.ssh/github_keys/$1

# backup directory
if [ ! -e  $HOME/.ssh/backup ]; then
  mkdir $HOME/.ssh/backup
fi

# backup config
if [ -f $HOME/.ssh/config ]; then
  cp $HOME/.ssh/config $HOME/.ssh/backup/config_backup
fi

# edit .ssh/config
cat << EOS >> $HOME/.ssh/config

Host $1
  Port 22
  HostName github.com
  IdentityFile ~/.ssh/github_keys/$1
  TCPKeepAlive yes
  IdentitiesOnly yes
EOS

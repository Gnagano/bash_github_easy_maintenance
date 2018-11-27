The shell scripts which makes github's maintenance easier
===

# Overviews

There are 4 shell scripts which makes github's maintenance easier.
Those scripts are

### 1. github_del_repo.sh

  - Delete github repository on github api.

### 2. github_keygen.sh

  - Genereate private and public key for localhost.

### 3. github_initial_clone.sh

  - Generate access private and public keys.
  - Deploy these keys on Github
  - Clone the private repository by ssh access.

### 4. github_initial_deploy.sh project_name

  - Generate access private and public keys.
  - Create the new repository on Github
  - Git push all branch for currency direcoty (current directory should be git managed.).

## Setup

### 1. Get the api token

Get the api access token for Github from [this page](https://github.com/settings/tokens) and put somewhere on your computer.

### 2. Set and edit setting.conf

Copy setting.conf.default as setting.conf

Change the settings.conf to your information as below.

  ```
  #! /bin/sh
  USER="your_github_user_name"              # -> your github account name
  ACCESS_TOKEN="$HOME/.github/github_token" # -> the place you put the token file
  GITHUB_API_URL="https://api.github.com"   # -> github api url
  KEY_COMMENT="your_comment"                # -> comment for execute 'keygen' command.
  KEY_TITLE="your_key_title"                # -> your key title on Github key page
  ```

## Usage

### 1. github_del_repo.sh

When you want to delete repository whose name is `test`, like below

  ```
  $ ./github_del_repo.sh test
  ```

### 2. github_keygen.sh

When you want to generate rsa keys for repository whose name is `test`, like below

  ```
  $ ./github_keygen.sh test
  ```

After executing this, the rsa keys are generated as the same name of project at `$HOME/.ssh/github_keys/`.
In this example, the keys' name are `test` (private key) and 'test.pub' (public key).
You need to answer on interactive question when the shell execute keygen command.

Furthermore, the config lines are added on `$HOME/.ssh/config`

  ```
  Host test
    Port 22
    HostName github.com
    IdentityFile ~/.ssh/github_keys/test
    TCPKeepAlive yes
    IdentitiesOnly yes
  ```

As you know, the host name of `test` and IdentityFile name are just example, the value should be the same as repository name.
That is why, you can access the repository by `git@<repository_name>:<your_github_user_name>/<repository_name>.git`

### 3. github_initial_clone.sh

When you want to clone the private repository whose name is `test`, like below

  ```
  $ ./github_initial_clone.sh test
  ```

You need to answer on interactive question when the shell execute keygen command.
You do not need to deploy the key by yourself because this shell automatically do that.

### 4. github_initial_deploy.sh

When you want to create the new private repository on Github whose name is `test`, like below

  ```
  $ ./github_initial_deploy.sh test
  ```

This command should be executed on git managed repository because push the codes to new repository on Github.
You need to answer on interactive question when the shell execute keygen command.
You do not need to access Github page on browser to make new repository.

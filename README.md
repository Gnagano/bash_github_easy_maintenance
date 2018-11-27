The shell scripts which makes github's maintenance easier

===

## Overviews

There are 4 shell scripts which makes github's maintenance easier.
Those scripts are

1. `github_del_repo.sh project_name`

  * Delete github repository on github api.

2. `github_keygen.sh [ -C comment ] project_name`

  * Genereate private and public key for localhost.

3. `github_initial_clone.sh project_name`

  * Generate access private and public keys.
  * Deploy these keys on Github
  * Clone the private repository by ssh access.

4. `github_initial_deploy.sh project_name`

  * Generate access private and public keys.
  * Create the new repository on Github
  * Git push all branch for currency direcoty (current directory should be git managed.).

## Usage








## Requirements

After running the playbook, reload bash_profile like below.

```
$ exec $SHELL -l
```

## Usage

### Install several envs (rbenv, pyenv, phpenv etc..)

In default, the roles install only pyenv.
Change the variable whose name is "anyenv_install_envs" in defaults/main.yml if you want to do other envs.

### Change anyenv directory

In default, anyenv folder is /opt/anyenv.
If you define {{ user }}, the install directory will be changed to /home/{{ user }}/.anyenv

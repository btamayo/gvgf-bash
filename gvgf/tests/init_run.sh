#!/usr/bin/env bash

# Run from project root

# This sets up the project folder so that we can update git-related items in the project
# Symlink all of the things that need to be called from the project into run_dir

# Initialize git-flow with this branching model, default GitVersion.yaml, and needed files in a new directory

# This packages the files needed to run a test execution
function new_directory()
{
  mkdir package
  CDIR=`pwd`
  cp tox.ini $CDIR
  cp helpers.py $CDIR
  cp GitVersion.yml $CDIR
  cp bash_utils.sh $CDIR
  cp setup.py $CDIR
}

ln -sf `pwd`/tox.ini `pwd`/run_dir/tox.ini
ln -sf `pwd`/helpers.py `pwd`/run_dir/helpers.py
ln -sf `pwd`/GitVersion.yml `pwd`/run_dir/GitVersion.yml
ln -sf `pwd`/bash_utils.sh `pwd`/run_dir/bash_utils.sh
ln -sf `pwd`/setup.py `pwd`/run_dir/setup.py
ln -sf `pwd`/project_gitignore `pwd`/run_dir/.gitignore
ln -sf `pwd`/git_flow_cfg_test `pwd`/run_dir/git_flow_cfg_test

if [ "$DOCKER_ENV" = "1" ]
then
    # Git Flow
    sh("echo \"alias gitversion='mono \"${(pwd)}\"/GitVersion_3.6.5/GitVersion.exe'\" >> ~/.bash_profile")
    sh("echo \"alias gv='gitversion'\" >> ~/.bash_profile")
    echo "Inside docker container"
    echo "
alias gffs='git flow feature start'
alias gfff='git flow feature finish'
alias gfrs='git flow release start'
alias gfrf='git flow release finish'
alias gfhs='git flow hotfix start'
alias gfhf='git flow hotfix finish'
alias gfbs='git flow bugfix start'
alias gfbf='git flow bugfix finish'
alias gv='gitversion'" >> ~/.bash_profile
fi

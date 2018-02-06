#!/usr/bin/env bash

## execute from absolute path of script

# Determine ultimate script dir. using the helper function.
# Note that the helper function returns a canonical path.
source ./helpers.bash || source ./tests/helpers.bash
scriptDir=$(dirname -- "$(rreadlink "$BASH_SOURCE")")
## Helpers
echo $scriptDir
cd $scriptDir || exit

# This packages the files needed to run a test execution
new_directory() {
  mkdir package
  CDIR="$PWD"
  cp helpers.py "$CDIR"
  cp GitVersion.yml "$CDIR"
  cp bash_utils.sh "$CDIR"
}

## Procedure
# 1. 
# Setup path to gitversion if it needs it (Docker)
if [ "$DOCKER_ENV" = "1" ]
then
  # PWD is project root
  echo "$USER"
  touch monoalias.txt
  echo "alias gitversion='mono $(pwd)/GitVersion_3.6.5/GitVersion.exe'" >> monoalias.txt
  cat monoalias.txt >> /root/.bashrc
fi



# Create temp dir for tests
rm -rf run_dir || true
mkdir -p run_dir || true

ln -sf "$PWD/helpers.py" "$PWD/run_dir/helpers.py"
ln -sf "$PWD/GitVersion.yml" "$PWD/run_dir/GitVersion.yml"
ln -sf "$PWD/bash_utils.sh" "$PWD/run_dir/bash_utils.sh"
ln -sf "$PWD/project_gitignore" "$PWD/run_dir/.gitignore"
ln -sf "$PWD/git_flow_cfg_test" "$PWD/run_dir/git_flow_cfg_test"

if [ "$DOCKER_ENV" = "1" ]; then
    # Git Flow
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
	alias gv='gitversion'" >> aliases.sh
	source ./aliases.sh
	hash -r
fi


# Initialize git repo in tests
# cd run_dir # IMPORTANT
# ./bash_utils.sh delete_git
# ./bash_utils.sh reinit_git



echo $(random_ticket_name)




















#!/usr/bin/env bash

# Run from project root

# This sets up the project folder so that we can update git-related items in the project
# Symlink all of the things that need to be called from the project into run_dir

# Initialize git-flow with this branching model, default GitVersion.yaml, and needed files in a new directory

# This packages the files needed to run a test execution
new_directory() {
  mkdir package
  CDIR="$PWD"
  cp tox.ini "$CDIR"
  cp helpers.py "$CDIR"
  cp GitVersion.yml "$CDIR"
  cp bash_utils.sh "$CDIR"
  cp setup.py "$CDIR"
}

echo 'Printing pwd'
echo "$PWD"
echo 'Printing directory contents'
ls -Al
mkdir -p run_dir || true
ln -sf "$PWD/tox.ini" "$PWD/run_dir/tox.ini"
ln -sf "$PWD/helpers.py" "$PWD/run_dir/helpers.py"
ln -sf "$PWD/GitVersion.yml" "$PWD/run_dir/GitVersion.yml"
ln -sf "$PWD/bash_utils.sh" "$PWD/run_dir/bash_utils.sh"
ln -sf "$PWD/setup.py" "$PWD/run_dir/setup.py"
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

bats
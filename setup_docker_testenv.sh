#!/usr/bin/env bash
# Run before any tests if GitVersion is not installed to symlink it to ~/.bash_profile

if [ "$DOCKER_ENV" = "1" ]
then
  # PWD is project root
  echo "$USER"
  echo "alias gitversion='mono \"$(pwd)\"/GitVersion_3.6.5/GitVersion.exe'\" >> /root/.bashrc"
  cd gvgf/tests && ./init_run.sh
  # @SEE: Jenkinsfile will then take over from this point and run pytest
fi

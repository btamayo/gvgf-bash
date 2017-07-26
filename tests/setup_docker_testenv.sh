#!/usr/bin/env bash
# Run before any tests if GitVersion is not installed to symlink it to ~/.bash_profile

if [ "$DOCKER_ENV" = "1" ]
then
  # PWD is project root
  echo "$USER"
  touch monoalias.txt
  echo "alias gitversion='mono $(pwd)/GitVersion_3.6.5/GitVersion.exe'" >> monoalias.txt
  cat monoalias.txt >> /root/.bashrc
  cd gvgf/tests && ./init_run.sh && source aliases.sh
fi

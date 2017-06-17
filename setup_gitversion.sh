# Run before any tests if GitVersion is not installed to symlink it to ~/.bash_profile

if [ "$DOCKER_ENV" = "1" ]
then
  # PWD is project root
  echo $USER
  echo "alias gitversion='mono \"$(pwd)\"/GitVersion_3.6.5/GitVersion.exe'\" >> /root/.bashrc"
fi

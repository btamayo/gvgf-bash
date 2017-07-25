FROM btamayo/python_test:latest

# Install additional deps
RUN mkdir -p app
WORKDIR app/

COPY . .

RUN apt-get update && apt-get -y install git-all
RUN wget --no-check-certificate -q  https://raw.githubusercontent.com/petervanderdoes/gitflow-avh/develop/contrib/gitflow-installer.sh && bash gitflow-installer.sh install stable; rm gitflow-installer.sh

RUN './setup_docker_testenv.sh'
# RUN cd gvgf/tests && pytest
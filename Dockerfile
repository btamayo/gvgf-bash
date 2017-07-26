FROM btamayo/bats:latest

# Install additional deps
RUN mkdir -p app
WORKDIR app/

RUN apt-get update && apt-get -y install git-all

RUN wget --no-check-certificate -q https://raw.githubusercontent.com/petervanderdoes/gitflow-avh/develop/contrib/gitflow-installer.sh && bash gitflow-installer.sh install stable \
	rm gitflow-installer.sh

RUN apt-get update && apt-get install -y \
	file \
	build-essential \
	wget \
	curl \
	vim \
	make \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

COPY . .

# RUN './setup_docker_testenv.sh'
# RUN cd gvgf/tests && pytest
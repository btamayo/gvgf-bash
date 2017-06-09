FROM python:2.7

# Install additional deps
RUN mkdir -p app
WORKDIR app/
COPY . app/

ARG DEBIAN_FRONTED=noninteractive

# Install required testing frameworks
RUN pip install -U pylint pytest virtualenv

# Install Mono for gitversion support
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb http://download.mono-project.com/repo/debian jessie main" | tee /etc/apt/sources.list.d/mono-official.list \
    && apt-get -y update

RUN apt-get -y install mono-complete libcurl3

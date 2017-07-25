FROM btamayo/python_test:latest

# Install additional deps
RUN mkdir -p app
WORKDIR app/

COPY . .

RUN './setup_docker_testenv.sh'
# RUN cd gvgf/tests && pytest
FROM python:2.7

# Install additional deps
RUN mkdir -p app
WORKDIR app/
COPY . app/

# Install required testing frameworks
RUN pip install -U pylint pytest

CMD ["pytest"]

FROM ubuntu:20.10

COPY install.sh install.sh

ENV GITHUB_TOKEN=${GITHUB_TOKEN}

RUN GITHUB_TOKEN=${GITHUB_TOKEN} ./install.sh && rm install.sh


FROM ubuntu:20.10

COPY install.sh install.sh

ARG TOKEN
RUN GITHUB_TOKEN=$TOKEN ./install.sh && rm install.sh

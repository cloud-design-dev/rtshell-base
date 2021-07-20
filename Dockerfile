
FROM ubuntu:20.10

COPY install.sh install.sh

RUN ./install.sh && rm install.sh

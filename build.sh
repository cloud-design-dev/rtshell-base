#!/bin/bash
docker build --build-arg GITHUB_TOKEN=${GITHUB_TOKEN} -t greyhoundforty/rtshell-base .

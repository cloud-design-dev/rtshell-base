#!/bin/bash
set -e

echo ">> Installing dependencies..."
apt-get -qq update
PACKAGES=(
  apache2-utils \
  apt-transport-https \
  bash-completion \
  ca-certificates \
  curl \
  gnupg \
  inetutils-ping \
  jq \
  locales \
  lsb-release \
  nano \
  python3-argcomplete \
  python3-pip \
  python3-setuptools \
  python3-virtualenv \
  silversearcher-ag \
  software-properties-common \
  sudo \
  tmux \
  unzip \
  vim \
  wget \
  zsh \
  zip \
)

for package in "${PACKAGES[@]}"; do
  echo "Processing $package..."
  apt-get install -qq -y $package || true
done

# Locale
echo ">> Locale"
locale-gen en_US.UTF-8

# Docker in Docker
echo ">> Docker in Docker"
apt remove docker docker-engine docker.io containerd runc || true
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get -qq update
apt-get -qq -y install docker-ce docker-ce-cli containerd.io


echo ">> TFSwitch"
curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash

echo ">> Blast Radius"
pip install blastradius

# Ansible
echo ">> Ansible"
apt-add-repository --yes --update ppa:ansible/ansible
apt-get install -qq -y ansible

# Yarn
echo ">> Yarn"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get -qq update && apt-get install -qq -y yarn

# MC for S3
echo ">> minio"
wget -O /usr/local/bin/mc https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x /usr/local/bin/mc

# Colors for nano
echo ">> Colors for nano"
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh

# Powerline
echo ">> Powerline"
pip install powerline-shell

# yq - jq for yaml
echo ">> yq"
pip install yq

# argcomplete
activate-global-python-argcomplete3

# Cleanup
echo ">> Cleanup"
apt-get clean && rm -rf /var/lib/apt/lists/*

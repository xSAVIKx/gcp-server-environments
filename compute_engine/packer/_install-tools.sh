#!/usr/bin/env bash

set -x

sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get -y install nano \
  wget \
  curl \
  bzip2 \
  htop \
  zip \
  unzip \
  git \
  python3.7 \
  python3.7-venv

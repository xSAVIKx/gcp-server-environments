#!/usr/bin/env bash

set -x

PACKER_VERSION="1.4.5"
PACKER_ARCHIVE="packer_${PACKER_VERSION}_linux_amd64.zip"

sudo mkdir /opt/packer

wget "https://releases.hashicorp.com/packer/${PACKER_VERSION}/${PACKER_ARCHIVE}"

sudo unzip -o "${PACKER_ARCHIVE}" -d /opt/packer/

rm "${PACKER_ARCHIVE}"

sudo ln -s -f /opt/packer/packer /usr/local/bin

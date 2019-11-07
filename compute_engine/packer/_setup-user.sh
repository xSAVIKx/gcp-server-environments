#!/usr/bin/env bash

GCE_HOME_DIR="${GCE_HOME_DIR:-/usr/local/gce}"
GCE_USER="${GCE_USER:-gce}"

sudo useradd -m -d "${GCE_HOME_DIR}" "${GCE_USER}"

# This directory is usually used by GCloud to store the default credentials and overall GCloud configurations
sudo mkdir -p "${GCE_HOME_DIR}/.config"

sudo chown -R "${GCE_USER}:${GCE_USER}" "${GCE_HOME_DIR}"

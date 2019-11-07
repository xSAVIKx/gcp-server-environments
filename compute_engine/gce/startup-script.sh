#!/usr/bin/env bash

logger -p "user.info" -t startup-script "Starting startup script execution..."

GCE_USER="${GCE_USER:-gce}"

sudo su - "${GCE_USER}" bash -c \
'
logger -p "user.info" -t startup-script "Cloning source code repository."
git clone https://github.com/xSAVIKx/gcp-server-environments.git

cd gcp-server-environments/compute_engine/

logger -p "user.info" -t startup-script "creating virtual environment."
python3.7 -m venv .venv

logger -p "user.info" -t startup-script "activating virtual environment."
source .venv/bin/activate
logger -p "user.info" -t startup-script "installing requirements."
pip install -r requirements.txt

gunicorn --bind :8080 --workers 1 --threads 8 --timeout 120 --log-file /var/log/gce/python-runner/runner.log.json --log-level DEBUG main:app
'

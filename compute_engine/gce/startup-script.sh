#!/usr/bin/env bash

GCE_HOME_DIR="${GCE_HOME_DIR:-/usr/local/gce}"
GCE_USER="${GCE_USER:-gce}"

git clone https://github.com/xSAVIKx/gcp-server-environments.git "${GCE_HOME_DIR}/gcp-server-environments"

sudo chown -R "${GCE_USER}:${GCS_USER}" "${GCE_HOME_DIR}/gcp-server-environments"

cd "${GCE_HOME_DIR}/gcp-server-environments/compute_engine"

sudo su - "${GCE_USER}" bash -c \
'
python3.7 -m venv .venv

source .venv/bin/activate

pip install -r requirements.txt

gunicorn --bind :8080 --workers 1 --threads 8 --timeout 120 --log-file /var/log/gce/python-runner/runner.log.json --log-level DEBUG main:app
'

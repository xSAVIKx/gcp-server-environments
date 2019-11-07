#!/usr/bin/env bash

set -x

GCE_LOG_DIR=/var/log/gce
GCE_HOME_DIR="${GCE_HOME_DIR:-/usr/local/gce}"
GCE_USER="${GCE_USER:-gce}"

sudo mkdir "${GCE_LOG_DIR}/python-runner" -p

sudo chown "${GCE_USER}:${GCE_USER}" "${GCE_LOG_DIR}" -R

sudo sh -c "cat > /etc/google-fluentd/config.d/python-runner.conf <<EOF
<source>
  @type tail
  format json
  path /var/log/gce/python-runner/runner.log.json
  pos_file /var/lib/google-fluentd/pos/python-runner.pos
  read_from_head true
  tag python-runner
</source>
EOF"

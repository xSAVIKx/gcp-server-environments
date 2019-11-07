#!/usr/bin/env bash

export GCLOUD_PROJECT="<your-project>"
export GCE_NETWORK="python-runner-network"
export DEPLOYMENT_BUCKET="gs://<your-bucket>"
export GCE_TARGET_POOL_NAME="python-runner-lb"
export GCE_RUNNER_IMAGE="gce-python-runner-v2019-11-07"
export MACHINE_TYPE="g1-small"

. ./_setup-network.sh
. ./_setup-load-balancer.sh
. ./_setup-managed-group.sh

#!/usr/bin/env bash

set -x
# Read GCloud project ID from the input or from the GCLOUD_PROJECT variable that should be available in the context
# of the current script
CURRENT_GCLOUD_PROJECT="${1:-$GCLOUD_PROJECT}"

NETWORK_NAME="${2:-$GCE_NETWORK}"
NETWORK_NAME="${NETWORK_NAME:-python-network}"

INSTANCE_TAG="python-runner"

# Define new GCP network
gcloud compute networks create "${NETWORK_NAME}" \
    --description="The dedicated network for the python-runner managed group" \
    --project="${CURRENT_GCLOUD_PROJECT}"

# Allow internal connections between GCP instances
gcloud compute firewall-rules create "${NETWORK_NAME}-allow-internal" \
    --network="${NETWORK_NAME}" \
    --allow="all" \
    --source-ranges="10.128.0.0/9" \
    --priority="65534" \
    --project="${CURRENT_GCLOUD_PROJECT}"

# Allow SSH connections
gcloud compute firewall-rules create "${NETWORK_NAME}-allow-ssh" \
    --network="${NETWORK_NAME}" \
    --allow="tcp:22" \
    --priority="65534" \
    --project="${CURRENT_GCLOUD_PROJECT}"

# Allow ICMP connections
gcloud compute firewall-rules create "${NETWORK_NAME}-allow-icmp" \
    --network="${NETWORK_NAME}" \
    --allow="icmp" \
    --priority="65534" \
    --project="${CURRENT_GCLOUD_PROJECT}"

# Allow HTTP connections on 8080 port to `python-runner`-tagged instances
gcloud compute firewall-rules create "${NETWORK_NAME}-allow-http" \
    --network="${NETWORK_NAME}" \
    --allow="tcp:8080"  \
    --target-tags="${INSTANCE_TAG}" \
    --priority="1000" \
    --project="${CURRENT_GCLOUD_PROJECT}"

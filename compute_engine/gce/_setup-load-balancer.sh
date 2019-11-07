#!/usr/bin/env bash

set -x
# Read GCloud project ID from the input or from the GCLOUD_PROJECT variable that should be available in the context
# of the current script
CURRENT_GCLOUD_PROJECT="${1:-$GCLOUD_PROJECT}"
# GCP region to create instances in
REGION="us-central1"

LB_IP_ADDRESS_NAME="python-runner-load-balancer"

LB_POOL_NAME="${2:-$GCE_TARGET_POOL_NAME}"
LB_POOL_NAME="${LB_POOL_NAME:-$LB_IP_ADDRESS_NAME-pool}"

# Reserve static IP address
gcloud compute addresses create "${LB_IP_ADDRESS_NAME}" \
    --region="${REGION}" \
    --description="Python Runner load balancer" \
    --project="${CURRENT_GCLOUD_PROJECT}"

gcloud compute target-pools create "${LB_POOL_NAME}" \
    --region="${REGION}" \
    --session-affinity="CLIENT_IP" \
    --description="Python Runner load balancer pool" \
    --project="${CURRENT_GCLOUD_PROJECT}"

gcloud compute forwarding-rules create python-runner-load-balancer-http \
    --region="${REGION}" \
    --target-pool="${LB_POOL_NAME}" \
    --address=${LB_IP_ADDRESS_NAME} \
    --ports="8080" \
    --project="${CURRENT_GCLOUD_PROJECT}"

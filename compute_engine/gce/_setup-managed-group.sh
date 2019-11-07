#!/usr/bin/env bash

set -x
# Read GCloud project ID from the input or from the GCLOUD_PROJECT variable that should be available in the context
# of the current script
CURRENT_GCLOUD_PROJECT="${1:-$GCLOUD_PROJECT}"
# GCP region to create instances in
REGION="us-central1"
# GCP zone to create instance in
ZONE="us-central1-a"

# Google Cloud Storage urls to the appropriate instance startup script
GCS_STARTUP_SCRIPT_URL="${DEPLOYMENT_BUCKET}/startup-script.sh"

GCE_RUNNER_IMAGE="${2:-$GCE_RUNNER_IMAGE}"
GCE_NETWORK="${3:-$GCE_NETWORK}"

MACHINE_TYPE="${4:-$MACHINE_TYPE}"
GCE_MACHINE_TYPE="${MACHINE_TYPE:-n1-standard-1}"

INSTANCE_TEMPLATE_NAME="python-runner"
MANAGED_GROUP_NAME="${INSTANCE_TEMPLATE_NAME}-group"
GROUP_SIZE=1

# ID of the project where the FTP image is.
GCE_IMAGE_PROJECT_ID="${5:-$GCE_IMAGE_PROJECT_ID}"
GCE_IMAGE_PROJECT_ID="${GCE_IMAGE_PROJECT_ID:-$CURRENT_GCLOUD_PROJECT}"

# Name of the Load balancer pool to attach created managed group to
GCE_TARGET_POOL_NAME="${6:-$GCE_TARGET_POOL_NAME}"
# Name of the health check that will be used for the auto-healing functionality
HEALTH_CHECK_NAME="python-runner-health-check"

INSTANCE_TAG="python-runner"

# Cleanup previously created group and template if any
gcloud compute instance-groups managed delete "${MANAGED_GROUP_NAME}" \
    --quiet \
    --zone="${ZONE}" \
    --project="${CURRENT_GCLOUD_PROJECT}"
gcloud compute instance-templates delete "${INSTANCE_TEMPLATE_NAME}" \
    --quiet \
    --project="${CURRENT_GCLOUD_PROJECT}"

gcloud compute instance-templates create "${INSTANCE_TEMPLATE_NAME}" \
    --image-project="${GCE_IMAGE_PROJECT_ID}" \
    --image="${GCE_RUNNER_IMAGE}" \
    --network="${GCE_NETWORK}" \
    --boot-disk-size="30GB" \
    --region="${REGION}" \
    --tags="${INSTANCE_TAG}" \
    --machine-type="${GCE_MACHINE_TYPE}" \
    --metadata="startup-script-url=${GCS_STARTUP_SCRIPT_URL}" \
    --labels="service=python-runner" \
    --boot-disk-device-name="${INSTANCE_TEMPLATE_NAME}-boot" \
    --scopes="https://www.googleapis.com/auth/devstorage.full_control,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/pubsub,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append,https://www.googleapis.com/auth/taskqueue,https://www.googleapis.com/auth/datastore,https://www.googleapis.com/auth/cloud-platform" \
    --project="${CURRENT_GCLOUD_PROJECT}"

gcloud compute instance-groups managed create "${MANAGED_GROUP_NAME}" \
    --size="${GROUP_SIZE}" \
    --description="Python Runner managed group" \
    --template="${INSTANCE_TEMPLATE_NAME}" \
    --zone="${ZONE}" \
    --target-pool="${GCE_TARGET_POOL_NAME}" \
    --project="${CURRENT_GCLOUD_PROJECT}"


# Define FTP instance health-check
gcloud compute health-checks create http "${HEALTH_CHECK_NAME}" \
    --port=8080 \
    --check-interval="180s" \
    --timeout="15s" \
    --project="${CURRENT_GCLOUD_PROJECT}"

gcloud compute instance-groups managed update "${MANAGED_GROUP_NAME}" \
    --initial-delay="300s" \
    --health-check="${HEALTH_CHECK_NAME}" \
    --zone="${ZONE}" \
    --project="${CURRENT_GCLOUD_PROJECT}"

gcloud compute instance-groups managed set-autoscaling "${MANAGED_GROUP_NAME}" \
    --max-num-replicas=2 \
    --min-num-replicas=0 \
    --target-cpu-utilization 0.75 \
    --zone="${ZONE}" \
    --project="${CURRENT_GCLOUD_PROJECT}"
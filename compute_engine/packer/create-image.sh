#!/usr/bin/env bash

set -x

export GCP_PROJECT_ID="<project-id>"
export GCP_ZONE="<zone>" # e.g. us-central1-a

packer build --timestamp-ui gce-runner.json

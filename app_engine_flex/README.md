App Engine Flex
-------

This package represents a GAE Flex deployment unit.

## How to deploy

Execute the following command from the terminal:

```bash

GCP_PROJECT_ID=<project-id>

gcloud app create \
    --region=us-central \
    --project="${GCP_PROJECT_ID}"

gcloud app deploy \
    --project="${GCP_PROJECT_ID}"

```

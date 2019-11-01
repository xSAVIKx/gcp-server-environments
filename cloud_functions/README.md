Google Cloud Functions
-------

This package represents a GCF deployment unit.

## How to deploy

Execute the following command from the terminal:

```bash

GCP_PROJECT_ID=<project-id>

gcloud functions deploy <function-name> \
    --region=us-central
    --entry-point=main
    --runtime=python37
    --trigger-http
    --memory=1024MB
    --project="${GCP_PROJECT_ID}"

```

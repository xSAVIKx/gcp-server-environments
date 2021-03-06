Cloud Run
-------

This package represents a Cloud Run deployment unit.

## How to deploy

Execute the following command from the terminal:

```bash

GCP_PROJECT_ID=<project-id>
GCR_TAG="gcr.io/${GCP_PROJECT_ID}/ru_proverbs"

gcloud builds submit \
    --tag="${GCR_TAG}" \
    --project="${GCP_PROJECT_ID}"

gcloud run deploy ru-proverbs \
    --image="${GCR_TAG}" \
    --region=us-central1 \
    --platform=managed \
    --allow-unauthenticated \
    --memory=1024M \
    --project="${GCP_PROJECT_ID}"

```

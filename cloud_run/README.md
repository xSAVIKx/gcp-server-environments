Cloud Run
-------

This package represents a Cloud Run deployment unit.

## How to deploy

Execute the following command from the terminal:

```bash

GCP_PROJECT_ID=<project-id>
GCR_TAG="gcr.io/${GCP_PROJECT_ID}/ru_proverbs"

# We have to copy all the sources with symlinks to a `build` folder to overcome inability 
# of Docker (and gcloud) to follow symlinks out of the working directory context.
rsync -RrL . ./build/
cd build

gcloud builds submit \
    --tag="${GCR_TAG}" \
    --project="${GCP_PROJECT_ID}"

cd ..
rm -rf build

gcloud beta run deploy ru-proverbs \
    --image="${GCR_TAG}" \
    --region=us-central1 \
    --platform=managed \
    --allow-unauthenticated \
    --memory=1024M \
    --project="${GCP_PROJECT_ID}"

```

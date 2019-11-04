#!/usr/bin/env sh

GCP_PROJECT_ID="<project-id>"

gcloud functions deploy ru-proverb \
--region=us-central1 \
--entry-point=main \
--runtime=python37 \
--trigger-http \
--memory=1024M \
--allow-unauthenticated \
--project="${GCP_PROJECT_ID}"

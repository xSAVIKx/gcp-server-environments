Google Cloud Functions
-------

This package represents a GCF deployment unit.

## How to deploy

Execute the following command from the terminal:
```bash
gcloud functions deploy <function-name> \
    --region=us-central1
    --entry-point=main
    --runtime=python37
    --trigger-http
    --memory=1024MB
    --project=<project-id>
```

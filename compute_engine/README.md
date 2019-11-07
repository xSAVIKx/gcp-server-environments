Google Compute Engine
-------

This package represents a GCE deployment unit.

## How to deploy

1. Install [packer][1] (e.g. run [install-packer.sh](./packer/install-packer.sh)).
2. Run Packer to create a new GCE image (see [create-image.sh](./packer/create-image.sh)).
3. Copy [startup-script.sh](./gce/startup-script.sh) to the deployment bucket 
(you can create one with `gsutil mb`).
4. Create GCE services: network, load balancer and managed group. 
(see [setup-python-runner.sh](./gce/setup-python-runner.sh)).

[1]: https://packer.io

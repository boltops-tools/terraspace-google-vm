# Terraspace Google VM Example

This project shows how to use the [Google VM Terraform registry module](https://registry.terraform.io/modules/terraform-google-modules/vm/google) with [Terraspace](https://terraspace.cloud/).

* Thanks and credit goes to the author of this module: Aaron L.
* Most contributors are doing this on their own free time. Please support them. Contribute back and send them a pull request. Some may ask for donations. Donate to them. Some are consultants. Hire them.

## Setup

    git clone https://github.com/boltops-tools/terraspace-google-vm
    cd terraspace-google-vm
    bundle

## Deploy

Make sure the `GOOGLE_PROJECT` and `GOOGLE_REGION` env variables are set your google project. One easy way to set them:

    export GOOGLE_PROJECT=`gcloud config get-value project`
    export GOOGLE_REGION=`gcloud config get-value compute/region`

Then deploy:

    terraspace up vm

A vm named `instance-simple-001` is created.

## Updating

To update the modules to the latest version from the Terraform registry.

    terraspace bundle update

## More Examples

    $ terraspace list
    app/stacks/vm

Note, the module has many more examples. The Terrafile has been configured to use only one of the examples.

## About

[![BoltOps Badge](https://img.boltops.com/boltops/badges/boltops-badge.png)](https://www.boltops.com)

[Terraspace](https://terraspace.cloud/) and this project was built by [BoltOps](https://www.boltops.com). We also offer:

* [Paid Consulting Services](https://www.boltops.com/consulting)
* [BoltOps Pro: Infrastructure Code as a Service](https://www.boltops.com/pro)

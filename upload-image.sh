#! /usr/bin/env bash

# Upload the image to S3 (here my configuration in the s3-config file points to
# a Digital Ocean Space). The corresponding HTTPS URL will then be used to
# import the image into my Digital Ocean custom images.
#
# "hypered" is the name of my S3 bucket.
#
# Note that the image is publicly accessible (although it URL should ne known),
# don't put sensitive stuff in it.

s3cmd -c s3-config put result/nixos.qcow2.gz s3://hypered --acl-public

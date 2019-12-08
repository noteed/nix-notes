#! /usr/bin/env bash

# Import an image into Digital Ocean from an URL. The URL here is from a S3
# bucket where we have uploaded the image.

doctl compute image create nix-notes \
  --region ams3 \
  --image-url https://hypered.ams3.digitaloceanspaces.com/nixos.qcow2.gz \
  --image-description 'Example image from my nix-notes'

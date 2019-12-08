#! /usr/bin/env bash

# Build a virtual machine image suitable for Digital Ocean. The resulting file
# will be result/nixos.qcow2.gz.
#
# Note that we need a recent nixpkgs Git repository that knows about the
# digitalOceanImage attribute.

nix-build -A image

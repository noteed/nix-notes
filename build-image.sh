#! /usr/bin/env bash

# Build a virtual machine image suitable for Digital Ocean. The resulting file
# will be result/nixos.qcow2.gz.
#
# Note that we need a recent nixpkgs Git repository that knows about the
# digitalOceanImage attribute.

nix_args=(
)

if [[ -n $1 ]]; then
  nix_args+=(--arg configuration "$1")
fi

nix-build -A image "${nix_args[@]}"

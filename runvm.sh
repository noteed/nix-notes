#! /usr/bin/env bash

# Type Ctrl-a x to exit QEMU.

set -e

nix-build -A runvm
./result/bin/run-nixos-vm

#! /usr/bin/env bash

# This script builds the new system, uploads it and activates it on the target
# system. This is similar to the following blog post:
# https://vaibhavsagar.com/blog/2019/08/22/industrial-strength-deployments/.

set -euo pipefail

TARGET="root@165.22.200.188"

echo Building toplevel...
GIT_DESCRIBE=$(git describe --dirty --long)
PROFILE_PATH="$(nix-build --no-out-link -A toplevel \
  --argstr nix-notes-version $GIT_DESCRIBE)"
echo $PROFILE_PATH

echo Copying toplevel closure to target system...
nix-copy-closure --to --use-substitutes $TARGET $PROFILE_PATH

echo Activating copied toplevel...
ssh $TARGET -- \
  "nix-env --profile /nix/var/nix/profiles/system --set $PROFILE_PATH && \
   /nix/var/nix/profiles/system/bin/switch-to-configuration switch"

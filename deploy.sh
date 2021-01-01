#! /usr/bin/env bash

# This script builds the new system, uploads it and activates it on the target
# system. This is similar to the following blog post:
# https://vaibhavsagar.com/blog/2019/08/22/industrial-strength-deployments/.

set -euo pipefail

nix_args=(
)

if [[ -n $1 ]]; then
  nix_args+=(--arg configuration "$1")
fi

TARGET="root@165.22.200.188"

echo Building toplevel...
GIT_DESCRIBE=$(git describe --dirty --long)
PROFILE_PATH="$(nix-build \
  -A toplevel \
  --no-out-link \
  --argstr nix-notes-version $GIT_DESCRIBE \
  "${nix_args[@]}"
  )"
echo $PROFILE_PATH

echo Copying toplevel closure to target system...
nix-copy-closure --to --use-substitutes $TARGET $PROFILE_PATH

echo Copying secrets to target system...
scp secrets/ssmtp-authpass $TARGET:/run/keys/ssmtp-authpass

echo Activating copied toplevel...
ssh $TARGET -- \
  "nix-env --profile /nix/var/nix/profiles/system --set $PROFILE_PATH && \
   /nix/var/nix/profiles/system/bin/switch-to-configuration switch"

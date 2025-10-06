#!/bin/sh
set -euo pipefail

FLAKE_PATH=$(dirname -- $BASH_SOURCE)
cd $FLAKE_PATH
nix build .#packages.x86_64-linux.iso

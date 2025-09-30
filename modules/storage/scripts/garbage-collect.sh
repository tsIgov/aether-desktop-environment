#! @bash@
set -e

@notify-send@ -e -a aether "Garbage collection started"
@nix-collect-garbage@
@nix-store@ --optimize
@notify-send@ -e -a aether "Garbage collection finished"

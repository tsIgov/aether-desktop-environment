#! @bash@
set -e

@notify-send@ -e -a aether "Garbage collection started"
@nix-collect-garbage@ --delete-old
@nix-store@ --optimize
@notify-send@ -e -a aether "Garbage collection finished"

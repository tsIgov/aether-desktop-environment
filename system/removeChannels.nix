nixpkgs: 
{ config, lib, ... }: 
{

  options = {
    aether.system = with lib; with types; {
		  removeChannels = mkOption { type = bool; default = true; };
	  };
  };

  config = lib.mkIf (config.aether.system.removeChannels) {
    # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
    nix.registry.nixpkgs.flake = nixpkgs;
    nix.channel.enable = false; # remove nix-channel related tools & configs, we use flakes instead.

    # but NIX_PATH is still used by many useful tools, so we set it to the same value as the one used by this flake.
    # Make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
    environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
    # https://github.com/NixOS/nix/issues/9574
    nix.settings.nix-path = nixpkgs.lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
  };
}
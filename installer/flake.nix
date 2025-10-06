{
  description = "Custom NixOS installer ISO with networking, LUKS, and guided setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; # choose your channel
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.installer = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
		(nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
        # Our custom installer module
        ./installer.nix
      ];
    };

    # Build ISO
    packages.x86_64-linux.iso = self.nixosConfigurations.installer.config.system.build.isoImage;
  };
}

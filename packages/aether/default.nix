{ pkgs, aetherConfigLocation ? "/$HOME/.config/aether" }:

pkgs.stdenv.mkDerivation {
  name = "aether";
  pname = "aether";
  version = "1.0";

  src = ./aether.sh;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/aether
    chmod +x $out/bin/aether

    # Wrap with env var
    wrapProgram $out/bin/aether \
      --set AETHER_CONFIG_LOCATION "${aetherConfigLocation}"
  '';

  nativeBuildInputs = [ pkgs.makeWrapper ];
}

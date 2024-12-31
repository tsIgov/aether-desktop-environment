{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "Igov-GTK";
  version = "1.0";
  src = ./.;

	nativeBuildInputs = with pkgs; [ sassc ];

	buildPhase = ''
		cp -r $src/* $TMPDIR
    cd $TMPDIR
    ./build.sh
  '';


  installPhase = ''
		mkdir -p $out/share/themes/
		cp -r $TMPDIR/out/. $out/share/themes/
  '';

}
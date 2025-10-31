lib: { hex }:

let
	hexToDecMap = { "0" = 0; "1" = 1; "2" = 2; "3" = 3; "4" = 4; "5" = 5;
		"6" = 6; "7" = 7; "8" = 8; "9" = 9; "a" = 10; "b" = 11; "c" = 12;
		"d" = 13; "e" = 14; "f" = 15;
	};

	fromHex = h: hexToDecMap.${builtins.substring 0 1 h} * 16 + hexToDecMap.${builtins.substring 1 1 h};
	cleanHex = builtins.replaceStrings ["#"] [""] (lib.toLower hex);

	r = fromHex (builtins.substring 0 2 cleanHex);
	g = fromHex (builtins.substring 2 2 cleanHex);
	b = fromHex (builtins.substring 4 2 cleanHex);
in
"${toString r}, ${toString g}, ${toString b}"

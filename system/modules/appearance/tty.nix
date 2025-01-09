{ pkgs, config, ... }:
let 
	colorVariant = config.system.appearance.colorVariant;
in
{
	console = {
		font = "ter-124b";
		packages = with pkgs; [
			terminus_font
		];
		colors = 
			if (colorVariant == "latte") then [
				"eff1f5" "d20f39" "40a02b" "df8e1d" "1e66f5" "ea76cb" "179299" "4c4f69"
				"bcc0cc" "d20f39" "40a02b" "df8e1d" "1e66f5" "ea76cb" "179299" "6c6f85"
			]
			else if (colorVariant == "frappe") then [
				"303446" "e78284" "a6d189" "e5c890" "8caaee" "f4b8e4" "81c8be" "c6d0f5"
				"626880" "e78284" "a6d189" "e5c890" "8caaee" "f4b8e4" "81c8be""a5adce"
			]
			else if (colorVariant == "macchiato") then [
				"24273a" "ed8796" "a6da95" "eed49f" "8aadf4" "f5bde6" "8bd5ca" "cad3f5" 
				"5b6078" "ed8796" "a6da95" "eed49f" "8aadf4" "f5bde6" "8bd5ca" "a5adcb" 
			]
			else if (colorVariant == "mocha") then [
				"1e1e2e" "f38ba8" "a6e3a1" "f9e2af" "89b4fa" "f5c2e7" "94e2d5""cdd6f4"
				"585b70" "f38ba8" "a6e3a1" "f9e2af" "89b4fa" "f5c2e7" "94e2d5" "a6adc8"
			]
			else [];
	};
}
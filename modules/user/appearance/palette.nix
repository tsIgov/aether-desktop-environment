{ lib, ... }:

{
	options.appearance.colors.palette = with lib; with types; {
		primary = {
			tone-05 = mkOption { type = str; default = "160041"; };
			tone-10 = mkOption { type = str; default = "22005d"; };
			tone-15 = mkOption { type = str; default = "2d1067"; };
			tone-20 = mkOption { type = str; default = "381e72"; };
			tone-25 = mkOption { type = str; default = "432b7e"; };
			tone-30 = mkOption { type = str; default = "4f378a"; };
			tone-35 = mkOption { type = str; default = "5b4397"; };
			tone-40 = mkOption { type = str; default = "6750a4"; };
			tone-50 = mkOption { type = str; default = "8069bf"; };
			tone-60 = mkOption { type = str; default = "9a82db"; };
			tone-70 = mkOption { type = str; default = "b69df8"; };
			tone-80 = mkOption { type = str; default = "cfbcff"; };
			tone-90 = mkOption { type = str; default = "e9ddff"; };
			tone-95 = mkOption { type = str; default = "f6eeff"; };
			tone-98 = mkOption { type = str; default = "fdf7ff"; };
			tone-99 = mkOption { type = str; default = "fffbff"; };
		};

		secondary = {
			tone-05 = mkOption { type = str; default = "130e20"; };
			tone-10 = mkOption { type = str; default = "1e192b"; };
			tone-15 = mkOption { type = str; default = "282336"; };
			tone-20 = mkOption { type = str; default = "332d41"; };
			tone-25 = mkOption { type = str; default = "3e384c"; };
			tone-30 = mkOption { type = str; default = "4a4458"; };
			tone-35 = mkOption { type = str; default = "564f64"; };
			tone-40 = mkOption { type = str; default = "625b70"; };
			tone-50 = mkOption { type = str; default = "7b738a"; };
			tone-60 = mkOption { type = str; default = "958da4"; };
			tone-70 = mkOption { type = str; default = "b0a7bf"; };
			tone-80 = mkOption { type = str; default = "ccc2db"; };
			tone-90 = mkOption { type = str; default = "e8def8"; };
			tone-95 = mkOption { type = str; default = "f6edff"; };
			tone-98 = mkOption { type = str; default = "fef7ff"; };
			tone-99 = mkOption { type = str; default = "fffbff"; };
		};

		tertiary = {
			tone-05 = mkOption { type = str; default = "240612"; };
			tone-10 = mkOption { type = str; default = "31101c"; };
			tone-15 = mkOption { type = str; default = "3d1b27"; };
			tone-20 = mkOption { type = str; default = "4a2531"; };
			tone-25 = mkOption { type = str; default = "56303c"; };
			tone-30 = mkOption { type = str; default = "633b48"; };
			tone-35 = mkOption { type = str; default = "704653"; };
			tone-40 = mkOption { type = str; default = "7e525f"; };
			tone-50 = mkOption { type = str; default = "996a78"; };
			tone-60 = mkOption { type = str; default = "b58391"; };
			tone-70 = mkOption { type = str; default = "d29dac"; };
			tone-80 = mkOption { type = str; default = "f0b8c7"; };
			tone-90 = mkOption { type = str; default = "ffd9e2"; };
			tone-95 = mkOption { type = str; default = "ffecf0"; };
			tone-98 = mkOption { type = str; default = "fff8f8"; };
			tone-99 = mkOption { type = str; default = "fffbff"; };
		};

		neutral = {
			tone-05 = mkOption { type = str; default = "111016"; };
			tone-10 = mkOption { type = str; default = "1c1b21"; };
			tone-15 = mkOption { type = str; default = "27252c"; };
			tone-20 = mkOption { type = str; default = "312f37"; };
			tone-25 = mkOption { type = str; default = "3c3a42"; };
			tone-30 = mkOption { type = str; default = "48464d"; };
			tone-35 = mkOption { type = str; default = "545159"; };
			tone-40 = mkOption { type = str; default = "605d65"; };
			tone-50 = mkOption { type = str; default = "79767e"; };
			tone-60 = mkOption { type = str; default = "938f98"; };
			tone-70 = mkOption { type = str; default = "aea9b3"; };
			tone-80 = mkOption { type = str; default = "c9c5ce"; };
			tone-90 = mkOption { type = str; default = "e6e0ea"; };
			tone-95 = mkOption { type = str; default = "f4eff9"; };
			tone-98 = mkOption { type = str; default = "fdf8ff"; };
			tone-99 = mkOption { type = str; default = "fffbff"; };
		};

		neutral-variant = {
			tone-05 = mkOption { type = str; default = "120f18"; };
			tone-10 = mkOption { type = str; default = "1d1a23"; };
			tone-15 = mkOption { type = str; default = "28242e"; };
			tone-20 = mkOption { type = str; default = "322f38"; };
			tone-25 = mkOption { type = str; default = "3e3a44"; };
			tone-30 = mkOption { type = str; default = "49454f"; };
			tone-35 = mkOption { type = str; default = "55515b"; };
			tone-40 = mkOption { type = str; default = "615c67"; };
			tone-50 = mkOption { type = str; default = "7a7580"; };
			tone-60 = mkOption { type = str; default = "948e9a"; };
			tone-70 = mkOption { type = str; default = "afa9b5"; };
			tone-80 = mkOption { type = str; default = "cbc4d1"; };
			tone-90 = mkOption { type = str; default = "e7e0ed"; };
			tone-95 = mkOption { type = str; default = "f6eefb"; };
			tone-98 = mkOption { type = str; default = "fef7ff"; };
			tone-99 = mkOption { type = str; default = "fffbff"; };
		};

		error = {
			tone-05 = mkOption { type = str; default = "2d0001"; };
			tone-10 = mkOption { type = str; default = "410002"; };
			tone-15 = mkOption { type = str; default = "540003"; };
			tone-20 = mkOption { type = str; default = "690005"; };
			tone-25 = mkOption { type = str; default = "790e0e"; };
			tone-30 = mkOption { type = str; default = "8a1c18"; };
			tone-35 = mkOption { type = str; default = "9a2822"; };
			tone-40 = mkOption { type = str; default = "ab342c"; };
			tone-50 = mkOption { type = str; default = "cc4c42"; };
			tone-60 = mkOption { type = str; default = "ee6559"; };
			tone-70 = mkOption { type = str; default = "ff897d"; };
			tone-80 = mkOption { type = str; default = "ffb4ab"; };
			tone-90 = mkOption { type = str; default = "ffdad6"; };
			tone-95 = mkOption { type = str; default = "ffedea"; };
			tone-98 = mkOption { type = str; default = "fff8f7"; };
			tone-99 = mkOption { type = str; default = "fffbff"; };
		};
	};
}
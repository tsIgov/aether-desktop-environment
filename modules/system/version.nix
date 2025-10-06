{ config, lib, ... }:
let
	release = config.system.nixos.release;
	version = config.system.nixos.version;
	distroName = "AetherOS";
	distroId = "aetheros";
	vendorName = "Tsvetan Igov";
	vendorId = "tsigov";
	codeName = "Alchemy";

	needsEscaping = s: null != builtins.match "[a-zA-Z0-9]+" s;
	escapeIfNecessary = s: if needsEscaping s then s else ''"${lib.escape [ "$" "\"" "\\" "`" ] s}"'';
	attrsToText = attrs: 	lib.concatStringsSep "\n" (lib.mapAttrsToList (n: v: ''${n}=${escapeIfNecessary (toString v)}'') attrs) + "\n";
in
{
	environment.etc = {
		"lsb-release".text = lib.mkForce (attrsToText ({
				LSB_VERSION = "${release} (${codeName})";
				DISTRIB_ID = "${distroId}";
				DISTRIB_RELEASE = release;
				DISTRIB_CODENAME = lib.toLower codeName;
				DISTRIB_DESCRIPTION = "${distroName} ${release} (${codeName})";
			}
		));

		"os-release".text = lib.mkForce (attrsToText ({
			NAME = "${distroName}";
			ID = "${distroId}";
			ID_LIKE = "nixos";
			VENDOR_NAME = vendorName;
			VERSION = "${release} (${codeName})";
			VERSION_CODENAME = lib.toLower codeName;
			VERSION_ID = release;
			BUILD_ID = version;
			PRETTY_NAME = "${distroName} ${release} (${codeName})";
			CPE_NAME = "cpe:/o:${vendorId}:${distroId}:${release}";
			LOGO = "aether-logo";
			HOME_URL =  "https://github.com/tsIgov/aethe";
			#   ANSI_COLOR = optionalString isNixos "0;38;2;126;186;228";
			#   IMAGE_ID = optionalString (config.system.image.id != null) config.system.image.id;
			#   IMAGE_VERSION = optionalString (config.system.image.version != null) config.system.image.version;
			#   VARIANT = optionalString (cfg.variantName != null) cfg.variantName;
			#   VARIANT_ID = optionalString (cfg.variant_id != null) cfg.variant_id;
			#   DEFAULT_HOSTNAME = config.system.nixos.distroId;
		}));

		"issue".text = lib.mkForce "<<< Welcome to ${distroName} ${codeName} >>>";
	};

	system.nixos.label = codeName;
}

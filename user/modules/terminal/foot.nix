{ ... }:
{
	programs.foot = {
		enable = true;
	};
	# programs.foot.settings = {};

	home.file = {
		".config/foot/foot.ini".source = ./foot.ini;
	};
}

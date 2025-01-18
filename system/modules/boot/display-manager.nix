{ pkgs, config, lib, ... }:
let 
	variant = config.aether.appearance.variant;
	accent = config.aether.appearance.accent;
	colors = lib.colors.${variant};
in
{
  environment.systemPackages = with pkgs; [
    (where-is-my-sddm-theme.override {
      themeConfig.General = {
        backgroundFill = "#${colors.base}";
        basicTextColor = "#${colors.subtext0}";
        passwordCursorColor = "#${colors.${accent}}";
        passwordInputBackground = "#${colors.base}";
        passwordTextColor = "#${colors.${accent}}";
        cursorBlinkAnimation = true;
        hideCursor = true;
      };
    })
  ];



  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "where_is_my_sddm_theme";
    extraPackages = [
      pkgs.kdePackages.qt5compat
    ];
    wayland = {
      enable = true;
      compositor = "kwin";
    };
    autoNumlock = true;
  };
}

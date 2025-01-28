{ pkgs, config, aether, ... }:
let 
	flavorName = config.aether.appearance.flavor;
	accent = config.aether.appearance.accent;
	flavor = aether.lib.appearance.flavors.${flavorName};
in
{
  environment.systemPackages = with pkgs; [
    (where-is-my-sddm-theme.override {
      themeConfig.General = {
        backgroundFill = "#${flavor.base}";
        basicTextColor = "#${flavor.subtext0}";
        passwordCursorColor = "#${flavor.${accent}}";
        passwordInputBackground = "#${flavor.base}";
        passwordTextColor = "#${flavor.${accent}}";
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

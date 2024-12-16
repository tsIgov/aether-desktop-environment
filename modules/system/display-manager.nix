{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --remember-session --user-menu --time --time-format '%Y-%m-%d %H:%M:%S' --cmd Hyprland";
        user = "greeter";
      };
    };
  };
}
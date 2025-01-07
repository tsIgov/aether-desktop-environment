{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];

  console.colors = [
    "24273a" # black
    "ed8796" # red
    "a6da95" # green
    "eed49f" # yellow
    "8aadf4" # blue
    "f5bde6" # magenta
    "8bd5ca" # cyan
    "cad3f5" # white
    "5b6078" # bright black
    "ed8796" # bright red
    "a6da95" # bright green
    "eed49f" # bright yellow
    "8aadf4" # bright blue
    "f5bde6" # bright magenta
    "8bd5ca" # bright cyan
    "a5adcb" # bright white
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --remember-session --user-menu --asterisks --time --time-format '%Y-%m-%d %H:%M:%S' --window-padding 1 --theme 'border=magenta;text=white;prompt=red;time=white;action=white;button=blue;input=green;title=white'";
        user = "greeter";
      };
    };
  };
}
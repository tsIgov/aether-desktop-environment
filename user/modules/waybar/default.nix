{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 20;

        modules-left = [ "hyprland/workspaces" "hyprland/window"];
        modules-center = [ "clock" ];
        modules-right = [ "hyprland/language" "backlight" "bluetooth" "battery" "network" "pulseaudio" "tray" ];

        "hyprland/workspaces" = {
          on-click = "activate";
          active-only = false;
          all-outputs = true;
          sort-by-number = true;
          show-special = false;

          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
            "6" = [ ];
            "7" = [ ];
            "8" = [ ];
            "9" = [ ];
            "10" = [ ];
          };

          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "0";
          };
        };


        "hyprland/window" = {
          icon = true;
          format = "{class}";
        };

        "clock" = {
          format = "{:%H:%M}";
          format-alt = "{:%A, %B %d, %Y (%R)}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };


        "hyprland/language" = {
          format = "{short}";
        };

        "backlight" = {
          format = "{percent}% {icon}";
          format-icons = [ "" "" ];
        };

        "bluetooth" = {
          format = " {status}";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          #format-device-preference = [ "device1" "device2" ]; // preference list deciding the displayed device
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };

        "battery"= {
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = [ " " " " " " " " " " ];
          max-length = 25;
        };

        "network"= {
          interval = 1;
          format = "󰲝 ";
          format-wifi = "{icon}";
          format-ethernet = "󰲝 ";
          format-disconnected = "󰲜 "; # An empty format will hide the module.
          format-icons = [ "󰤯 " "󰤟 " "󰤢 " "󰤥 " "󰤨 " ];
          tooltip-format = "{ifname}\nip: {ipaddr}\nmask: {netmask}\nvia {gwaddr}\nupload: {bandwidthUpBytes}\ndownload: {bandwidthDownBytes}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)\n{ifname}\nip: {ipaddr}\nmask: {netmask}\nvia {gwaddr}\nupload: {bandwidthUpBytes}\ndownload: {bandwidthDownBytes}";
          tooltip-format-ethernet = "{ifname}\nip: {ipaddr}\nmask: {netmask}\nvia {gwaddr}\nupload: {bandwidthUpBytes}\ndownload: {bandwidthDownBytes}";
          tooltip-format-disconnected = "Disconnected";
          on-click = "foot nmtui";
          on-click-right = "nmcli dev wifi list --rescan yes";
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "󰝟 ";
          format-icons = {
            default = [ "" " " " " ];
          };
          scroll-step = 1;
          on-click = "foot pulsemixer";
          ignored-sinks = [ "Easy Effects Sink" ];
        };

        "tray" = {
          icon-size = 20;
        };
      };
    };
    style = ./style.css;
  };
}

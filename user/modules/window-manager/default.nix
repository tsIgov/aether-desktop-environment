{ config, ... }:

{

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      monitor = [
        ",preferred,auto,auto"
      ];

      general = {
        layout = "master";
        no_focus_fallback = true;
        resize_on_border = true;
      };

      input = {
        kb_layout = "us,bg";
        kb_variant = ",phonetic";
        kb_options = "grp:caps_toggle";

        numlock_by_default = true;
        follow_mouse = 2;
        float_switch_override_focus = 0;

        scroll_method = "2fg";

        touchpad = {
            clickfinger_behavior = true;
            drag_lock = true;
            tap-and-drag = true;
        };
      };

      group = {
        insert_after_current = false;
        focus_removed_window = true;

        groupbar = {
            scrolling = false;
        };
      };

      misc = {
        disable_autoreload = true;

        focus_on_activate = true;
        mouse_move_focuses_monitor = false;

        close_special_on_empty = true;
        new_window_takes_over_fullscreen = 2;

        initial_workspace_tracking = 0;
        middle_click_paste = false;
      };

      binds = {
        focus_preferred_method = 1;
        movefocus_cycles_fullscreen = true;
      };

      windowrulev2 = [
        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "nofocus,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
      ];

      workspace = [
        "special:scratchpad, gapsout:200, on-created-empty:foot"
      ];
    };

    extraConfig = ''
      # Set programs that you use
      $terminal = foot
      $fileManager = nemo

      $mainMod = SUPER

      bind = $mainMod, Q, exec, $terminal
      bind = $mainMod, C, killactive, 
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, D, togglefloating 
      bind = $mainMod, F, fullscreen, 1
      bind = SUPER, SUPER_L, exec, pkill anyrun || anyrun
      bind = $mainMod, L, exec, pidof swaylock || swaylock
      

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d


      # Move windows with mainMod + Shift + arrow keys
      bind = $mainMod SHIFT, left, movewindoworgroup, l
      bind = $mainMod SHIFT, right, movewindoworgroup, r
      bind = $mainMod SHIFT, up, movewindoworgroup, u
      bind = $mainMod SHIFT, down, movewindoworgroup, d


      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Example special workspace (scratchpad)
      bind = $mainMod, S, togglespecialworkspace, scratchpad
      bind = $mainMod SHIFT, S, movetoworkspace, special:scratchpad

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Resize
      bind = $mainMod, M, submap, resize
      submap=resize
      binde = $mainMod, right, resizeactive, 20 0
      binde = $mainMod, left, resizeactive, -20 0
      binde = $mainMod, up, resizeactive, 0 -20
      binde = $mainMod, down, resizeactive, 0 20
      bind = $mainMod SHIFT, left, movewindow, l
      bind = $mainMod SHIFT, right, movewindow, r
      bind = $mainMod SHIFT, up, movewindow, u
      bind = $mainMod SHIFT, down, movewindow, d
      bind = , escape, submap, reset 
      submap = reset

      # Grouping
      bind = $mainMod, tab, changegroupactive, f
      bind = $mainMod SHIFT, tab, changegroupactive, b
      bind = $mainMod, G, togglegroup 
      bind = $mainMod, space, lockactivegroup, toggle
    '';
  };
}


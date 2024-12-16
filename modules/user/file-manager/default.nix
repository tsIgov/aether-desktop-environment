{ pkgs, ... }:

{
	home.file = {
		".local/share/nemo/actions/create-archive.nemo_action".source = ./actions/create-archive.nemo_action;
		".local/share/nemo/actions/extract.nemo_action".source = ./actions/extract.nemo_action;
		".local/share/nemo/actions/open-in-terminal.nemo_action".source = ./actions/open-in-terminal.nemo_action;
	};

  dconf = {
    settings = {
      "org/nemo" = {
          "compact-view/all-columns-have-same-width" = false;

          "icon-view/captions" = ["none" "size" "date_modified"];
          "icon-view/labels-beside-icons" = false;

          "list-view/default-column-order" = ["name" "size" "type" "detailed_type" "date_modified" "date_created_with_time" "date_accessed" "date_created" "group" "where" "mime_type" "date_modified_with_time" "octal_permissions" "owner" "permissions"];
          "list-view/default-visible-columns" = ["name" "size" "detailed_type" "date_modified"];
          "list-view/default-zoom-level" = "smaller";

          "plugins/disabled-actions" = ["90_new-launcher.nemo_action" "change-background.nemo_action" "set-as-background.nemo_action" "add-desklets.nemo_action" "add-desklets.nemo_action" "set-as-background.nemo_action" "change-background.nemo_action" "90_new-launcher.nemo_action" "set-resolution.nemo_action" "set-resolution.nemo_action" "mount-archive.nemo_action" "mount-archive.nemo_action"];


          "preferences/default-folder-viewer" = "icon-view";
          "preferences/default-sort-order" = "name";
          "preferences/detect-content" = false;
          "preferences/inherit-folder-viewer" = true;
          "preferences/show-compact-view-icon-toolbar" = true;
          "preferences/show-computer-icon-toolbar" = false;
          "preferences/show-edit-icon-toolbar" = false;
          "preferences/show-home-icon-toolbar" = true;
          "preferences/show-icon-view-icon-toolbar" = true;
          "preferences/show-location-entry" = false;
          "preferences/show-new-folder-icon-toolbar" = true;
          "preferences/show-next-icon-toolbar" = true;
          "preferences/show-open-in-terminal-toolbar" = false;
          "preferences/show-previous-icon-toolbar" = true;
          "preferences/show-reload-icon-toolbar" = false;
          "preferences/show-show-thumbnails-toolbar" = false;
          "preferences/show-up-icon-toolbar" = true;
          "preferences/sort-favorites-first" = false;
          "preferences/start-with-dual-pane" = false;

          "preferences/menu-config/background-menu-open-as-root" = true;
          "preferences/menu-config/background-menu-open-in-terminal" = false;
          "preferences/menu-config/desktop-menu-customize" = false;
          "preferences/menu-config/iconview-menu-arrange-items" = false;
          "preferences/menu-config/iconview-menu-organize-by-name" = false;
          "preferences/menu-config/selection-menu-copy" = true;
          "preferences/menu-config/selection-menu-copy-to" = true;
          "preferences/menu-config/selection-menu-cut" = true;
          "preferences/menu-config/selection-menu-favorite" = false;
          "preferences/menu-config/selection-menu-move-to" = true;
          "preferences/menu-config/selection-menu-open-as-root" = false;
          "preferences/menu-config/selection-menu-open-in-new-tab" = false;
          "preferences/menu-config/selection-menu-open-in-new-window" = false;
          "preferences/menu-config/selection-menu-open-in-terminal" = false;
          "preferences/menu-config/selection-menu-paste" = true;
          "preferences/menu-config/selection-menu-pin" = true;

          "search/search-reverse-sort" = false;
          "search/search-sort-column" = "name";

          "sidebar-panels/tree/show-only-directories" = false;

          "window-state/my-computer-expanded" = true;
          "window-state/side-pane-view" = "places";
          "window-state/start-with-menu-bar" = true;
          "window-state/start-with-sidebar" = true;
          "window-state/start-with-status-bar" = true;
      };
    };
  }; 

}

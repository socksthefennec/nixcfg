{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  cfg = config.sockscfg.desktop.gnome;
  extensions = with pkgs.gnomeExtensions; [
    appindicator
    go-to-last-workspace
    pano
    removable-drive-menu
    caffeine
    quake-terminal
  ];
in {
  options.sockscfg.desktop.gnome = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable the GNOME desktop.
      '';
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    environment.systemPackages = extensions ++ [pkgs.adw-gtk3];
    services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];
    home-manager.users.${config.sockscfg.user.name} = {
      dconf.settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions =
            builtins.map
            (extension: extension.extensionUuid)
            extensions;
          favorite-apps = [];
        };
        # TODO: wallpapers
        # "org/gnome/desktop/background" = {
        #   picture-uri = null;
        #   picture-uri-dark = null;
        # };
        # "org/gnome/desktop/screensaver" = {
        #   picture-uri = null;
        #   picture-uri-dark = null;
        # };
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          gtk-theme = "adw-gtk3-dark";
          enable-hot-corners = false;
        };
        "org/gnome/desktop/peripherals/touchpad" = {
          natural-scroll = false;
          tap-to-click = true;
          two-finger-scrolling-enabled = true;
        };
        "org/gnome/desktop/wm/keybindings" = {
          switch-to-workspace-1 = ["<Super>1"];
          switch-to-workspace-2 = ["<Super>2"];
          switch-to-workspace-3 = ["<Super>3"];
          switch-to-workspace-4 = ["<Super>4"];
          switch-to-workspace-5 = ["<super>5"];
          switch-to-workspace-6 = ["<Super>6"];
          switch-to-workspace-7 = ["<Super>7"];
          switch-to-workspace-8 = ["<Super>8"];
          switch-to-workspace-9 = ["<Super>9"];
          switch-to-workspace-10 = ["<Super>0"];

          move-to-workspace-1 = ["<Shift><Super>1"];
          move-to-workspace-2 = ["<Shift><Super>2"];
          move-to-workspace-3 = ["<Shift><Super>3"];
          move-to-workspace-4 = ["<Shift><Super>4"];
          move-to-workspace-5 = ["<Shift><Super>5"];
          move-to-workspace-6 = ["<Shift><Super>6"];
          move-to-workspace-7 = ["<Shift><Super>7"];
          move-to-workspace-8 = ["<Shift><Super>8"];
          move-to-workspace-9 = ["<Shift><Super>9"];
          move-to-workspace-10 = ["<Shift><Super>0"];

          switch-windows = ["<Alt>Tab"];
          switch-windows-backward = ["<Shift><Alt>Tab"];

          switch-applications = [];
          switch-applications-backward = [];
        };
        "org/gnome/desktop/wm/preferences" = {
          num-workspaces = 10;
        };
        "org/gnome/mutter" = {
          dynamic-workspaces = false;
        };
        "org/gnome/shell/extensions/appindicator" = {
          icon-opacity = 255;
        };
        "org/gnome/shell/extensions/go-to-last-workspace" = {
          shortcut-key = ["<Super>Tab"];
        };
        "org/gnome/shell/extensions/quake-terminal" = {
          always-on-top = true;
          render-on-current-monitor = true;
          terminal-id = mkIf config.sockscfg.applications.kitty.enable "kitty.desktop";
          terminal-shortcut = ["<Shift><Super>Return"];
        };
        "org/gnome/shell/keybindings" = {
          switch-to-application-1 = [];
          switch-to-application-2 = [];
          switch-to-application-3 = [];
          switch-to-application-4 = [];
          switch-to-application-5 = [];
          switch-to-application-6 = [];
          switch-to-application-7 = [];
          switch-to-application-8 = [];
          switch-to-application-9 = [];
        };
      };
    };
  };
}

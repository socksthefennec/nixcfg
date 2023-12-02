{
  config,
  pkgs,
  lib,
  ...
}: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  environment.systemPackages = with pkgs;
    [
      gnome.adwaita-icon-theme
    ]
    ++ (with pkgs.gnomeExtensions; [appindicator go-to-last-workspace pano]);
  services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];
}

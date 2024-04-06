{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types mkIf mkDefault mkOption;
  cfg = config.sockscfg.ranger;
in {
  options.sockscfg.ranger = {
    enable = mkOption {
      type = types.bool;
      default = config.sockscfg.enable;
      description = ''
        Whether to enable ranger file manager.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ranger];
    xdg.configFile."ranger/rc.conf".text = ''
      set viewmode miller
      set column_ratios 3,5
      set show_hidden true
      set confirm_on_delete multiple
      set preview_images true
      set preview_images_method kitty
    '';
  };
}

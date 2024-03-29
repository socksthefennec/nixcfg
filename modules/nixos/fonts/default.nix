{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  cfg = config.sockscfg.fonts;
in {
  options.sockscfg.fonts = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to configure and install fonts.
      '';
    };
  };
  config = mkIf cfg.enable {
    fonts = {
      packages = with pkgs; [
        twitter-color-emoji
        fira-code
        fira
      ];
      fontconfig = {
        defaultFonts = {
          sansSerif = ["Fira Sans"];
          monospace = ["Fira Code"];
          emoji = ["Twitter Color Emoji"];
        };
      };
    };
  };
}

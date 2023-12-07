{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption mkDefault types;
  cfg = config.sockscfg.applications.gaming;
in {
  options.sockscfg.applications.gaming = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to install games and game libraries e.g. steam.
      '';
    };
  };
  config = mkIf cfg.enable {
    programs.steam.enable = true;
    environment.systemPackages = with pkgs; [
      itch
      mindustry
    ];
  };
}

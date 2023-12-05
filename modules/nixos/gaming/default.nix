{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption mkDefault types;
  cfg = config.sockscfg.gaming;
in {
  options.sockscfg.gaming = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to install games and game libraries e.g. steam.
      '';
    };
  };
  config = {
    programs.steam.enable = true;
    environment.systemPackages = with pkgs; [
      itch
      mindustry
    ];
  };
}

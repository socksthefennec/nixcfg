{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types mkOption mkIf;
  cfg = config.sockscfg.applications.kitty;
in {
  options.sockscfg.applications.kitty = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable kitty systemwide.
      '';
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [kitty];
  };
}

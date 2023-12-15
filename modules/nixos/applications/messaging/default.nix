{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  cfg = config.sockscfg.applications.messaging;
in {
  options.sockscfg.applications.messaging = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to install messaging apps like telegram and discord.
      '';
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      sockscfg.forkgram
      discord
    ];
  };
}

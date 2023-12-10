{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types;
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
  config = {
    environment.systemPackages = with pkgs; [
      sockscfg.forkgram
      discord
    ];
  };
}

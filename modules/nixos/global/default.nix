{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types mkDefault mkOption;
  cfg = config.sockscfg;
in {
  options.sockscfg = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable Socks' config.
      '';
    };
  };
}

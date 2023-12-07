{
  lib,
  ...
}: let
  inherit (lib) types mkOption;
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

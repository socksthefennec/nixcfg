{
  lib,
  config,
  inputs,
  ...
}: let
  inherit (lib) types mkOption mkIf;
  cfg = config.sockscfg.channels;
in {
  options.sockscfg.channels = {
    enable = mkOption {
      type = types.bool;
      default = config.sockscfg.enable;
      description = ''
        Whether to configure the system's nix channels.
      '';
    };
  };

  config = mkIf cfg.enable {
    nix = {
      #TODO: all inputs?
      registry.nixpkgs.flake = inputs.nixpkgs;
      nixPath = [
        "nixpkgs=${inputs.nixpkgs}"
        "/nix/var/nix/profiles/per-user/root/channels"
      ];
    };
  };
}

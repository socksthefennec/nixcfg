{
  lib,
  config,
  nixpkgs,
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
      registry.nixpkgs.flake = nixpkgs;
      nixPath = [
        "nixpkgs=${nixpkgs}"
        "/nix/var/nix/profiles/per-user/root/channels"
      ];
    };
  };
}

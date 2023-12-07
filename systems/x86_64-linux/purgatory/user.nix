{
  config,
  lib,
  ...
}: let
  inherit (config) sockscfg;
in {
  services.xserver.displayManager.autoLogin = lib.mkIf config.services.xserver.enable {
    enable = true;
    user = sockscfg.user.name;
  };
  users.users.${sockscfg.user.name} = {
    initialHashedPassword = "$y$j9T$O663AsUwicdKYIQzKpqoV.$0VhavBNOGds5YLA.fBmASVR.PyWiE76Wgeh1QNG1LE4";
    extraGroups = ["networkmanager"];
  };
  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "hm-bak";
    users.${sockscfg.user.name} = {
      imports = [
        # ./dconf.nix
      ];
      sockscfg = {
        enable = true;
        graphics.enable = true;
      };
      home.stateVersion = config.system.stateVersion;
    };
  };
}

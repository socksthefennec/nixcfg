{
  config,
  pkgs,
  lib,
  ...
}: let
  user = {
    name = "socks";
    fullName = "Socks Candy";
    email = "socksthefennec@gmail.com";
    gpgKey = "B74F16D7F971CE9E840F815BCE83F5E5DDD46B29";
  };
in {
  services.xserver.displayManager.autoLogin = lib.mkIf config.services.xserver.enable {
    enable = true;
    user = user.name;
  };
  users.users.${user.name} = {
    isNormalUser = true;
    initialHashedPassword = "$y$j9T$O663AsUwicdKYIQzKpqoV.$0VhavBNOGds5YLA.fBmASVR.PyWiE76Wgeh1QNG1LE4";
    description = user.fullName;
    extraGroups = ["networkmanager" "wheel"];
  };
  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "hm-bak";
    users.${user.name} = {
      imports = [
        # ./dconf.nix
      ];
      sockscfg = {
        enable = true;
        graphics.enable = true;
      };
      # home.packages = with pkgs; [gnupg pinentry];
      home.stateVersion = config.system.stateVersion;
    };
  };
}

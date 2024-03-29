{lib, ...}: let
  inherit (lib) types mkOption;
in {
  options.sockscfg.user = {
    name = mkOption {
      type = types.str;
      default = "socks";
      description = ''
        The user's login name.
      '';
    };
    fullName = mkOption {
      type = types.str;
      default = "Socks Candy";
      description = ''
        The user's full name.
      '';
    };
    email = mkOption {
      type = types.str;
      default = "socksthefennec@gmail.com";
      description = ''
        The user's email address.
      '';
    };
    gpgKey = mkOption {
      type = types.str;
      default = "B74F16D7F971CE9E840F815BCE83F5E5DDD46B29";
      description = ''
        The user's gpg key.
      '';
    };
  };
}

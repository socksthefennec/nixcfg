{...}: let
  privkey = "/var/cache-priv-key.pem";
in {
  services.nix-serve = {
    enable = true;
    secretKeyFile = privkey;
    openFirewall = true;
  };
  nix.settings.secret-key-files = [privkey];
}

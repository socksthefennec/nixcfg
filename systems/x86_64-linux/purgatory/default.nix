{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./user.nix
  ];

  sockscfg = {
    desktop.gnome.enable = true;
    applications = {
      gaming.enable = true;
      messaging.enable = true;
    };
  };

  boot.plymouth = {
    enable = true;
  };

  services.fwupd.enable = true;

  time.timeZone = "Australia/Brisbane";

  i18n.defaultLocale = "en_AU.UTF-8";

  services.xserver = {
    layout = "au";
    xkbVariant = "";
  };

  sound.enable = true;
  security.rtkit.enable = true;
  #  services.pipewire = {
  #    enable = true;
  #    alsa.enable = true;
  #    alsa.support32Bit = true;
  #    pulse.enable = true;
  #    # If you want to use JACK applications, uncomment this
  #    #jack.enable = true;
  #
  #    # use the example session manager (no others are packaged yet so this is enabled by default,
  #    # no need to redefine it in your config for now)
  #    #media-session.enable = true;
  #  };

  services.gnome.gnome-keyring.enable = true;
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
  };
  services.dbus.packages = with pkgs; [gcr];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "23.11";
}

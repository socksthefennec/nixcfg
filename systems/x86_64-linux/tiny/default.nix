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
      kitty.enable = true;
    };
    binfmt.appimage.enable = true;
    fonts.enable = true;
  };

  environment.systemPackages = with pkgs; [watchmate htop makemkv gnome.gnome-software gnome-firmware gsmartcontrol gparted nixos-install-tools git];
  services.flatpak.enable = true;
  services.avahi = {
    enable = true;
    nssmdns = true;
  };
  services.openssh.enable = true;
  services.udev.extraRules = ''
    # Disable DS4 touchpad acting as mouse
    # USB
    ATTRS{name}=="Sony Computer Entertainment Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    ATTRS{name}=="Sony Interactive Entertainment Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    # Bluetooth
    ATTRS{name}=="Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';
  security.polkit.enable = true;

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

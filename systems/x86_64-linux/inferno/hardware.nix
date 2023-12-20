{
  config,
  lib,
  ...
}: {
  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
      kernelModules = [];
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/AD39-AA8C";
      fsType = "vfat";
    };
    "/" =
    { device = "/dev/disk/by-uuid/f4222a36-64f9-491c-9aa0-e9eb74210bcb";
      fsType = "btrfs";
      options = [ "subvol=nixos/@" ];
    };

  "/home" =
    { device = "/dev/disk/by-uuid/f4222a36-64f9-491c-9aa0-e9eb74210bcb";
      fsType = "btrfs";
      options = [ "subvol=nixos/@home" ];
    };

  };

  networking = {
    useDHCP = lib.mkDefault true;
    hostName = "inferno";
    networkmanager.enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}

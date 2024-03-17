{
  config,
  lib,
  ...
}: {
  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "ums_realtek" "sd_mod" "sr_mod"];
      kernelModules = ["kvm-intel"];
    };
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
    kernelModules = [];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/7292d1e3-3c09-465d-be3c-62be70c5e537";
      fsType = "btrfs";
      options = ["subvol=nixos/@"];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/7292d1e3-3c09-465d-be3c-62be70c5e537";
      fsType = "btrfs";
      options = ["subvol=nixos/@home"];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/7292d1e3-3c09-465d-be3c-62be70c5e537";
      fsType = "btrfs";
      options = ["subvol=nixos/@nix"];
    };
    "/var" = {
      device = "/dev/disk/by-uuid/7292d1e3-3c09-465d-be3c-62be70c5e537";
      fsType = "btrfs";
      options = ["subvol=nixos/@var"];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/2D96-5E5C";
      fsType = "vfat";
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/ce97e1dc-6405-4fc4-8df6-640fcb41c93e";}
  ];

  networking = {
    useDHCP = lib.mkDefault true;
    hostName = "decay";
    networkmanager.enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}

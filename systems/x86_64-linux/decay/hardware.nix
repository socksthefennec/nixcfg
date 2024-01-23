{
  config,
  lib,
  ...
}: {
  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "ehci_pci" "usb_storage" "sd_mod"];
      kernelModules = [];
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = [];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/4de18055-c638-44fd-b2d3-3d3d4a8f2df9";
      fsType = "btrfs";
      options = ["subvol=nixos/@"];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/4de18055-c638-44fd-b2d3-3d3d4a8f2df9";
      fsType = "btrfs";
      options = ["subvol=nixos/@home"];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/4de18055-c638-44fd-b2d3-3d3d4a8f2df9";
      fsType = "btrfs";
      options = ["subvol=nixos/@nix"];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/0D40-DAF3";
      fsType = "vfat";
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/62a55d92-6843-47b9-9ba5-1898a831ebc3";}
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

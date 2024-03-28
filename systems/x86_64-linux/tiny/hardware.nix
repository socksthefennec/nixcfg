{
  config,
  lib,
  ...
}: {
  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "nvme" "rtsx_pci_sdmmc"];
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
      device = "/dev/disk/by-uuid/df21fd65-2d22-4335-a2ab-8f7e4955c832";
      fsType = "btrfs";
      options = ["subvol=@"];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/df21fd65-2d22-4335-a2ab-8f7e4955c832";
      fsType = "btrfs";
      options = ["subvol=@home"];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/4406-0742";
      fsType = "vfat";
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/9e365ed3-fb76-4c05-aa08-d93acb50a682";}
  ];

  networking = {
    useDHCP = lib.mkDefault true;
    hostName = "tiny";
    networkmanager.enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}

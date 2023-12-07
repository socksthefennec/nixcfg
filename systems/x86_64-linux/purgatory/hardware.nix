{
  config,
  lib,
  ...
}: {
  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "ehci_pci" "usb_storage" "sd_mod"];
      kernelModules = ["amdgpu"];
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/7ad16ea1-1943-4b12-8ac8-2584d4af03f8";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/2279-4070";
      fsType = "vfat";
    };
  };

  swapDevices = [{device = "/dev/disk/by-uuid/035d6d6a-d52d-4d3d-adc0-018f6d86c3d3";}];

  networking = {
    useDHCP = lib.mkDefault true;
    hostName = "purgatory";
    networkmanager.enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}

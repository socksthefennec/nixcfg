{
  description = "Home Manager configuration of socks";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: let
    lib = inputs.snowfall-lib.mkLib {
      inherit inputs;
      src = ./.;
      snowfall = {
        namespace = "sockscfg";
        meta = {
          name = "sockscfg";
          title = "Socks' config";
        };
      };
    };
  in
    (lib.mkFlake {
      channels-config = {
        allowUnfree = true;
      };
      overlays = with inputs; [
        nur.overlay
        nixgl.overlay
      ];
      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        nix-flatpak.nixosModules.nix-flatpak
      ];
      outputs-builder = channels: {
        formatter = channels.nixpkgs.alejandra;
      };
    })
    // {
      hydraJobs = inputs.self.packages.x86_64-linux;
    };
}

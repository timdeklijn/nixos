{
  description = "A simple NixOS serving as entrypoint for my NixOS configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable"; # unstable channel

    # Used for user packages and dotfiles
    home-manager = {
      # url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs =
    {
      self,
      nixpkgs,
      unstable,
      home-manager,
      nix-flatpak,
      ...
    }:
    {
      # Describe my system
      nixosConfigurations = {
        fw13 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            nix-flatpak.nixosModules.nix-flatpak
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = [
                # 👇 Add the unstable overlay here
                (final: prev: {
                  unstable = import unstable {
                    inherit (prev.stdenv.hostPlatform) system;
                    config.allowUnfree = true; # optional
                  };
                })
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.users."tim" = import ./home.nix;
            }
          ];
        };
      };
    };
}

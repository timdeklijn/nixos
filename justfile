# Build a new NixOS generation while updating all packages.
rebuild:
    nix flake update
    sudo nixos-rebuild switch --flake . --upgrade --impure
# Tim de Klijn, 2025
#
# Justfile to collect nix related commands in.

_nix_rebuild:
    nix flake update
    sudo nixos-rebuild switch --flake . --upgrade --impure
    
# Build a new NixOS generation while updating all packages.
rebuild: _nix_rebuild
    #!/usr/bin/env bash
    set -euxo pipefail
    nixfmt *.nix
    GENERATION=$(sudo nix-env -p /nix/var/nix/profiles/system --list-generations | rg "current" | awk '{print $1}')
    git add .
    git commit -m "generation $GENERATION"
    git push

# Perform a firmware update of the current system.
firmware:
    sudo fwupdmgr refresh
    sudo fwupdmgr get-updates
    sudo fwupdmgr update
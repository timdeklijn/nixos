# Build a new NixOS generation while updating all packages.
_nix_rebuild:
    nix flake update
    sudo nixos-rebuild switch --flake . --upgrade --impure
    
rebuild: _nix_rebuild
    #!/usr/bin/env bash
    set -euxo pipefail
    GENERATION=$(sudo nix-env -p /nix/var/nix/profiles/system --list-generations | rg "current" | awk '{print $1}') && \
    echo "generation: $GENERATION"
    git add .
    git commit -m "generation $GENERATION"
    git push
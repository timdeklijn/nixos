# My NixOS system

## How to setup

The following command will:

1. upgrade flake
2. rebuild and switch nixos (including home manager)
3. format all `nix` files
3. extract generation number from current nixos-generation
4. commit and push changes with generation number in the commit message

``` sh
just rebuild
```
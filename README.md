# My NixOS system

## How to setup

## Dev setup

For python development, nothing beats a devcontainer. Untill NixOS actually works with python (`uv`) it is simply far easier to just spin up a container. To get git credential passthrough working it might be required to run:

``` sh
ssh-add $HOME/.ssh/id_rsa
```
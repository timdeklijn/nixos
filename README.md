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

## Citrix

Folowing steps from google gemini are followed to install citrix in a distrobox. It is installed in a distrobox because NixOS does not support the (mostly) deprecated dependencies of the citrix workspace.

Create and enter a Distrobox container: Use the distrobox-create command to set up a new container, for example, with a Fedora image, and then distrobox-enter to go inside.

```bash
distrobox-create --image fedora:latest my-citrix-box
distrobox-enter my-citrix-box
```

Install the Citrix Workspace app: Inside the container, install the Citrix Workspace app using the appropriate package manager for the container's base OS. For a Fedora container, you would use dnf and install the .rpm package downloaded from Citrix.
First, download the .rpm file from the official Citrix website.
Then, install it within the container.

``` bash
# Inside the container
sudo dnf install /path/to/your/citrix_workspace.rpm
```

Export the application: After the installation is complete, exit the container and use the distrobox-export command on your host to make the application available on your host's desktop menu.

```bash
# On the host
distrobox-export --app Citrix\ Application
```

Verify: A few moments after running distrobox-export, the Citrix Workspace application should appear in your host system's application launcher.

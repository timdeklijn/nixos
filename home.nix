{
  config,
  pkgs,
  ...
}:

let
  myFont = "SauceCodePro Nerd Font Mono";
in
{
  home.username = "tim";
  home.homeDirectory = "/home/tim";

  home.packages = with pkgs; [

    # AI coding
    # command line utilities
    fastfetch
    fd
    fzf
    git
    git-lfs
    nixfmt-rfc-style
    tmux
    unstable.btop
    unstable.codex
    unstable.delta
    direnv
    unstable.eza
    unstable.jq
    unstable.jujutsu
    unstable.just
    unstable.ripgrep
    starship
    unstable.yazi
    vim
    wget

    # editors
    unstable.jetbrains.idea-ultimate
    unstable.vscode-fhs
    unstable.zed-editor-fhs

    # Python dev support
    unstable.pyright # TODO: remove?
    unstable.ruff

    # 'GUI' programs
    audacity
    citrix_workspace # needs a manual download due to enduser license agreements
    unstable.ghostty
    unstable.networkmanagerapplet
    unstable.obsidian
    unstable.orca-slicer
    unstable.slack
    unstable.tidal-hifi

    gnome-tweaks
    gnome-shell-extensions
    gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-panel
    gnomeExtensions.focus-follows-workspace
    gnomeExtensions.search-light
    gnomeExtensions.vitals
    gnomeExtensions.open-bar
  ];

  imports = [
    (import ./applications/kitty.nix { inherit myFont; })
    (import ./applications/tmux.nix { inherit pkgs; })
    (import ./applications/wllogout.nix { inherit pkgs; })
    (import ./applications/shell.nix { inherit pkgs; })
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.file.".gitconfig".text = ''
    [core]
        pager = delta

    [interactive]
        diffFilter = delta --color-only

    [delta]
        navigate = true  # use n and N to move between diff sections
        dark = true      # or light = true, or omit for auto-detection

    [merge]
        conflictStyle = zdiff3

    [http "https://git.rws.nl"]
        sslCert = "~/git/rws/certificate/20251002-cert-csr.pem"
        sslKey = "~/git/rws/certificate/PRIVATE.key"

    [http "https://gitlab.at.rws.nl"]
        sslCert = "~/git/rws/certificate/20251002-cert-csr.pem"
        sslKey = "~/git/rws/certificate/PRIVATE.key"
  '';

  programs.ssh = {
    # I have tried to create my ssh config through home manager but openssh does
    # not really like links. This is why there is currently an unmanaged file
    # `~/.ssh/config`. These is some weird way to write a file on change, but
    # for now that seems like a hassle.
    enable = true;
  };
  home.file.".ssh/config".enable = false;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  programs.firefox = {
    enable = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}

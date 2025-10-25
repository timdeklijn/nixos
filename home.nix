{
  config,
  pkgs,
  ...
}:

let
  myFont = "SauceCodePro Nerd Font Mono";
  slackXwl = pkgs.writeShellScriptBin "slack-xwayland" ''
    #!/usr/bin/env bash
    set -euo pipefail
    export NIXOS_OZONE_WL=0
    exec ${pkgs.slack}/bin/slack "$@"
  '';
in
{
  home.username = "tim";
  home.homeDirectory = "/home/tim";

  home.packages = with pkgs; [

    # AI coding
    # command line utilities
    btop
    delta
    direnv
    fastfetch
    fd
    fzf
    ghostty
    git
    git-lfs
    jq
    just
    nixfmt-rfc-style
    ripgrep
    starship
    tmux
    unstable.eza
    unstable.jujutsu
    unstable.yazi
    vim
    wget
    unstable.codex

    # editors
    unstable.jetbrains.idea-ultimate
    unstable.zed-editor-fhs
    unstable.vscode-fhs

    # Python dev support
    unstable.ruff
    unstable.pyright

    # 'GUI' programs
    audacity
    citrix_workspace # needs a manual download due to enduser license agreements
    unstable.networkmanagerapplet
    unstable.slack
    unstable.obsidian
    unstable.orca-slicer
    unstable.tidal-hifi
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
    # preferences = {
    #     "widget.gtk.libadwaita-colors.enabled" = false;
    #   };
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

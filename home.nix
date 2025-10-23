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

    # Hyprland
    unstable.blueman
    unstable.grim
    unstable.hyprpaper
    unstable.hypridle
    unstable.slurp
    unstable.walker
    unstable.wofi
    unstable.xdg-desktop-portal-hyprland
    unstable.xwayland
    unstable.ashell

    # Python dev support
    unstable.ruff
    unstable.pyright

    # 'GUI' programs
    audacity
    citrix_workspace # needs a manual download due to enduser license agreements
    networkmanagerapplet
    slack
    slackXwl # custom wrapper for startup
    unstable.obsidian
    unstable.orca-slicer
    unstable.tidal-hifi
    unstable.zed-editor-fhs
  ];

  imports = [
    (import ./applications/vscode.nix { inherit pkgs myFont; })
    (import ./applications/kitty.nix { inherit myFont; })
    (import ./applications/tmux.nix { inherit pkgs; })
    (import ./applications/wllogout.nix { inherit pkgs; })
    (import ./applications/shell.nix { inherit pkgs; })
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  # This will force slack to start in 'x-wayland' mode. This is required because
  # it kept crashing in hyprland when run in wayland mode.
  xdg.desktopEntries.slack = {
    name = "Slack";
    exec = "slack-xwayland %U"; # point desktop entry to the wrapper
    terminal = false;
    type = "Application";
    categories = [
      "Network"
      "InstantMessaging"
    ];
    icon = "slack";
  };

  programs.hyprlock = {
    enable = true;
    package = pkgs.unstable.hyprlock;
  };

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

  services.emacs.enable = true;
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = (
      epkgs: [
        epkgs.vterm
        epkgs.treesit-grammars.with-all-grammars
      ]
    );
  };

  programs.firefox.enable = true;

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

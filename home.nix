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
    unstable.ashell
    # command line utilities
    btop
    delta
    direnv
    eza
    fastfetch
    fd
    fzf
    git
    git-lfs
    ghostty
    jq
    just
    nixfmt-rfc-style
    ripgrep
    starship
    tmux
    vim
    wget
    yazi
    zoxide

    codex

    blueman
    grim
    hyprlock
    hyprpaper
    hypridle
    slurp
    walker
    wofi
    xdg-desktop-portal-hyprland
    xwayland

    # Python dev support
    ruff
    pyright

    # Language servers for JSON/YAML/Docker/Nix
    yaml-language-server
    vscode-langservers-extracted # includes json-language-server
    dockerfile-language-server-nodejs
    nixd

    # Language servers for programming
    docker-language-server
    nodejs_24
    nodePackages.vscode-json-languageserver
    pyright
    yaml-language-server
    bash-language-server # Bash LSP
    odin
    ols

    # 'GUI' programs
    audacity
    citrix_workspace # needs a manual download due to enduser license agreements
    obsidian
    orca-slicer
    slackXwl
    slack
    spotify
    variety
    networkmanagerapplet
    zed-editor-fhs
    tidal-hifi
  ];

  imports = [
    (import ./applications/vscode.nix { inherit pkgs myFont; })
    (import ./applications/kitty.nix { inherit myFont; })
    (import ./applications/tmux.nix { inherit pkgs; })
    (import ./applications/wllogout.nix { inherit pkgs; })
    ./applications/shell.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

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

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
    git-credential-manager
    git-lfs
    nixfmt-rfc-style
    tmux
    unstable.btop
    unstable.codex
    unstable.opencode
    unstable.delta
    direnv
    unstable.eza
    unstable.jq
    unstable.jujutsu
    unstable.just
    unstable.ripgrep
    starship
    unstable.yazi
    unstable.lazygit
    unstable.tmux-sessionizer
    unstable.neovim
    unstable.gcc
    unstable.wl-clipboard
    unstable.azure-cli
    wget

    # editors
    unstable.vscode-fhs
    unstable.zed-editor-fhs
    unstable.helix
    unstable.sublime-merge
    unstable.sublime4

    # nix
    unstable.nixd

    # 'GUI' programs
    audacity
    google-chrome
    unstable.distrobox
    unstable.ghostty
    unstable.gnome-calendar
    unstable.logseq
    unstable.networkmanagerapplet
    unstable.obsidian
    unstable.orca-slicer
    unstable.slack
    unstable.tidal-hifi

    # gnome-tweaks
    # gnome-shell-extensions
    # gnome-tweaks
    # gnomeExtensions.appindicator
    # gnomeExtensions.dash-to-panel
    # gnomeExtensions.focus-follows-workspace
    # gnomeExtensions.search-light
    # gnomeExtensions.vitals
    # gnomeExtensions.open-bar
    # gnomeExtensions.night-theme-switcher
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

    [merge]
        conflictStyle = zdiff3

    [credential]
        helper = manager
        credentialStore = secretservice

    [filter "lfs"]
        clean = git-lfs clean -- %f
        smudge = git-lfs smudge -- %f
        process = git-lfs filter-process
        required = true

    # This is RWS specific.
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
    enableDefaultConfig = false;
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

  programs.firefox = {
    enable = true;
  };

  xdg.enable = true;

  # Create a microsoft teams PWA. This way I do not require a browser tab to be open.
  xdg.desktopEntries."microsoft-teams-pwa" = {
    name = "Microsoft Teams";
    genericName = "Teams";
    comment = "Microsoft Teams Progressive Web App";
    exec = "${pkgs.google-chrome}/bin/google-chrome-stable --app=https://teams.microsoft.com --class=MicrosoftTeams --name=MicrosoftTeams";
    icon = "microsoft-teams";
    categories = [
      "Network"
      "InstantMessaging"
    ];
    terminal = false;
    startupNotify = true;
  };

  # TODO: create a PWA for microsoft outlook

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

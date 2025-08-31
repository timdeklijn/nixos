{ config, pkgs, ... }:

{
  home.username = "tim";
  home.homeDirectory = "/home/tim";
  home.packages = with pkgs; [
    btop
    direnv
    eza
    fzf
    git
    git-lfs
    just
    kitty
    neofetch
    nixfmt-rfc-style
    ripgrep
    starship
    tmux
    vim
    wget
    zoxide

    # 'GUI' programs
    citrix_workspace # needs a manual download due to enduser license agreements
    dropbox
    obsidian
    signal-desktop
    slack
    spotify
    vscode-fhs
  ];
  programs.starship.enable = true;
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}

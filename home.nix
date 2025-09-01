{ config, pkgs, ... }:

{
  home.username = "tim";
  home.homeDirectory = "/home/tim";

  # nix.package = pkgs.nix;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);

  home.packages = with pkgs; [
    # command line utilities
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
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  programs.starship.enable = true;
  programs.firefox.enable = true;

  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = 1.0;
      confirm_os_window_close = false;
      font_family = "GeistMono Nerd Font Mono";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = "16.0";
      enable_audio_bell = "no";
      macos_titlebar_color = "background";
      background = "#000000";
      foreground = "#dcdccc";
      cursor = "#73635a";
      selection_background = "#21322f";
      color0 = "#4d4d4d";
      color8 = "#709080";
      color1 = "#705050";
      color9 = "#dca3a3";
      color2 = "#60b48a";
      color10 = "#c3bf9f";
      color3 = "#f0deae";
      color11 = "#dfcf9f";
      color4 = "#506070";
      color12 = "#94bff3";
      color5 = "#dc8cc3";
      color13 = "#ec93d3";
      color6 = "#8cd0d3";
      color14 = "#93e0e3";
      color7 = "#dcdccc";
      color15 = "#ffffff";
      selection_foreground = "#3f3f3f";
    };
  };

  programs.zsh = {
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
  };

  # zplug = {
  #   enable = true;
  #   plugins = [
  #     { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
  #     { name = "zsh-users/zsh-history-substring-search"; } # Simple plugin installation
  #     { name = "zsh-users/zsh-syntax-highlighting"; } # Simple plugin installation
  #     # { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
  #   ];
  # };

  # # Configure shell tools
  # programs.zsh = {
  #   enable = true;
  #   enableCompletion = true;
  #   autosuggestions.enable = true;
  #   # syntaxHighlighting.enable = true;
  #   enableSyntaxHighlighting = true;
  #   histSize = 10000;
  #   histFile = "$HOME/.zsh_history";
  #   setOptions = [
  #     "HIST_IGNORE_ALL_DUPS"
  #   ];
  # };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
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

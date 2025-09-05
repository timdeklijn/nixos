{ config, pkgs, ... }:

{
  home.username = "tim";
  home.homeDirectory = "/home/tim";

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
    fastfetch
    nixfmt-rfc-style
    ripgrep
    starship
    tmux
    vim
    wget
    zoxide

    # 'GUI' programs
    audacity
    citrix_workspace # needs a manual download due to enduser license agreements
    dropbox
    obsidian
    orca-slicer
    signal-desktop
    slack
    spotify
    vscode-fhs
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  programs.firefox.enable = true;

  programs.kitty = {
    enable = true;
    # These settings are simply copied from my kitty config.
    settings = {
      # Fonts
      font_family = "CaskaydiaMono Nerd Font Mono";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = "13.0";

      # Settings
      background_opacity = 0.9;
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
      macos_titlebar_color = "background";

      # Theme
      cursor = "#928374";
      cursor_text_color = "#000000";
      url_color = "#83a598";
      visual_bell_color = "#8ec07c";
      bell_border_color = "#8ec07c";
      active_border_color = "#d3869b";
      inactive_border_color = "#665c54";
      foreground = "#ebdbb2";
      background = "#1d2021";
      selection_foreground = "#928374";
      selection_background = "#ebdbb2";
      active_tab_foreground = "#fbf1c7";
      active_tab_background = "#665c54";
      inactive_tab_foreground = "#a89984";
      inactive_tab_background = "#3c3836";
      color0 = "#665c54";
      color8 = "#7c6f64";
      color1 = "#cc241d";
      color9 = "#fb4934";
      color2 = "#98971a";
      color10 = "#b8bb26";
      color3 = "#d79921";
      color11 = "#fabd2f";
      color4 = "#458588";
      color12 = "#83a598";
      color5 = "#b16286";
      color13 = "#d3869b";
      color6 = "#689d6a";
      color14 = "#8ec07c";
      color7 = "#a89984";
      color15 = "#bdae93";
    };
  };

  # Configure zsh with nice tools
  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    # This should be set to true, even if it is set to configuration.nix.
    enable = true;

    # enable suggestions, completions and highlighting
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    # Save zsh config files here.
    dotDir = ".config/zsh";

    # Add my zsh aliases. Requires `eza`.
    shellAliases = {
      ga = "git add";
      gs = "git status";
      gc = "git commit";
      gp = "git push";
      gP = "git pull";
      gl = "git log";
      k = "kubectl";
      kc = "kubectl ctx";
      kn = "kubectl ns";
      ls = "eza";
      ll = "eza -la";
    };
    # This should help being able to use git within devcontainers withou
    # running this command manually.
    initContent = ''
      ssh-add $HOME/.ssh/id_rsa > /dev/null 2>&1 &
    '';
  };

  # Make sure that I can use my ssh settings while in a devcontianer:
  home.file.".ssh/config".text = ''
    AddKeysToAgent yes
  '';

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    historyLimit = 100000;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    sensibleOnTop = true;
    escapeTime = 1;
    baseIndex = 1;
    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
      pkgs.tmuxPlugins.gruvbox
    ];
    extraConfig = ''
      # remap split panes
      bind | split-window -h
      bind _ split-window -v

      # vim style through resizing
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      set-option -g status-position bottom
    '';
  };

  # TODO: configure vscode

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

{
  config,
  pkgs,
  ...
}:
{
  home.username = "tim";
  home.homeDirectory = "/home/tim";

  home.packages = with pkgs; [
    # command line utilities
    btop
    delta
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

    nixd

    # 'GUI' programs
    audacity
    citrix_workspace # needs a manual download due to enduser license agreements
    obsidian
    orca-slicer
    slack
    spotify
    variety
    # vscode-fhs

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
    ./applications/vscode.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  programs.firefox.enable = true;

  dconf.enable = true;
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "Vitals@CoreCoding.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "search-light@icedman.org"
        "focus-follows-workspace@christopher.luebbemeier.gmail.com"
        "openbar@neuromorph"
      ];
    };
    "org/gnome/settings-daemon/plugins/power" = {
      ambient-enabled = false;
    };
    "org/gnome/mutter" = {
      # disable dynamic workspaces
      dynamic-workspaces = false;
      # set fixed number of workspaces
      num-workspaces = 4;
      experimental-features = [ "scale-monitor-framebuffer" ];
      workspaces-only-on-primary = true;
    };
    # This block clears the application switch bindings
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
      switch-to-application-5 = [ ];
      switch-to-application-6 = [ ];
      switch-to-application-7 = [ ];
      switch-to-application-8 = [ ];
      switch-to-application-9 = [ ];
      switch-to-application-10 = [ ];
    };
    "org/gnome/desktop/wm/keybindings" = {

      # These bindings will now correctly switch to workspaces
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];

      # Your existing move-to-workspace bindings are correct
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark"; # Adwaita-dark
      gtk-theme = "Adwaita-dark";
      icon-theme = "Adwaita";
      cursor-theme = "Adwaita";
      clock-format = "24h";
      clock-show-weekday = true;
      enable-animations = true;
      text-scaling-factor = 1.0;
      enable-hot-corners = false;
      show-battery-percentage = true;
    };
    "org/gnome/desktop/sound" = {
      event-sounds = false;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = false; # Set to false to reverse "natural" scrolling
    };
  };

  programs.kitty = {
    enable = true;
    # These settings are simply copied from my kitty config.
    settings = {
      # Fonts
      font_family = "JetBrainsMono Nerd Font Mono";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = "15.0";

      # Settings
      background_opacity = 0.95;
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
      macos_titlebar_color = "background";
      linux_display_server = "x11";

      foreground = "#adbac7";
      background = "#22272e";
      selection_foreground = "#22272e";
      selection_background = "#539bf5";
      cursor = "#539bf5";
      tab_bar_background = "#1c2128";
      active_tab_foreground = "#adbac7";
      active_tab_background = "#22272e";
      inactive_tab_foreground = "#768390";
      inactive_tab_background = "#1c2128";
      color0 = "#545d68";
      color8 = "#636e7b";
      color1 = "#f47067";
      color9 = "#ff938a";
      color2 = "#57ab5a";
      color10 = "#6bc46d";
      color3 = "#c69026";
      color11 = "#daaa3f";
      color4 = "#539bf5";
      color12 = "#6cb6ff";
      color5 = "#b083f0";
      color13 = "#dcbdfb";
      color6 = "#39c5cf";
      color14 = "#56d4dd";
      color7 = "#909dab";
      color15 = "#cdd9e5";
    };
  };

  # Configure zsh with nice tools
  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.direnv.enable = true;
  programs.git.delta.enable = true;
  programs.zsh = {
    # This should be set to true, even if it is set to configuration.nix.
    enable = true;

    autocd = true;
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
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'
      # ssh-add $HOME/.ssh/id_rsa > /dev/null 2>&1 &
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
      pkgs.tmuxPlugins.tmux-nova
    ];
    extraConfig = ''
      set-option -g status-position bottom

      # set -g @nova-nerdfonts true
      # set -g @nova-nerdfonts-left 
      # set -g @nova-nerdfonts-right 

      # set -g @nova-segment-mode "#{?client_prefix,Ω,ω}"
      # set -g @nova-segment-mode-colors "#50fa7b #282a36"

      # set -g @nova-segment-whoami "#(whoami)@#h"
      # set -g @nova-segment-whoami-colors "#50fa7b #282a36"

      # set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}  #W"

      # set -g @nova-rows 0
      # set -g @nova-segments-0-left "mode"
      # set -g @nova-segments-0-right "whoami"

      # remap split panes
      bind | split-window -h
      bind _ split-window -v

      # vim style through resizing
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

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

{
  config,
  pkgs,
  ...
}:

let
  myFont = "JetBrainsMono Nerd Font Mono";
in

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
    chromium

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
    (import ./applications/vscode.nix { inherit pkgs myFont; })
    (import ./applications/kitty.nix { inherit myFont; })
    (import ./applications/tmux.nix { inherit pkgs; })
    ./applications/gnome.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

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

    HOST gitlab.com
        Hostname altssh.gitlab.com
        User git
        Port 443
  '';

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

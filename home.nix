{
  config,
  pkgs,
  ...
}:

let
  myFont = "Maple Mono NF CN";
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
    fastfetch
    fzf
    git
    git-lfs
    jq
    just
    kitty
    nixfmt-rfc-style
    ripgrep
    starship
    tmux
    vim
    wget
    yazi
    zoxide

    # Not a nerdfont
    maple-mono.NF-CN-unhinted

    nixd

    # sublime text editor
    sublime4-dev
    sublime-merge

    # Language servers for programming
    docker-language-server
    nodejs_24
    nodePackages.vscode-json-languageserver
    pyright
    yaml-language-server

    # 'GUI' programs
    audacity
    citrix_workspace # needs a manual download due to enduser license agreements
    obsidian
    orca-slicer
    slack
    spotify
    variety
  ];

  imports = [
    (import ./applications/vscode.nix { inherit pkgs myFont; })
    (import ./applications/kitty.nix { inherit myFont; })
    (import ./applications/tmux.nix { inherit pkgs; })
    ./applications/shell.nix
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

  # Make sure that I can use my ssh settings while in a devcontianer:
  home.file.".ssh/config".text = ''
    AddKeysToAgent yes

    # NOTE: this is used for RWS datalab
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

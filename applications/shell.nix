{ pkgs }:
{
  # Startship prompt looks nice
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # zoxide for faster jumping to and from folders
  programs.zoxide = {
    enable = true;
    package = pkgs.unstable.zoxide; # or pkgs.zoxide, but pick one
    enableFishIntegration = true;
  };

  # search through history
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  # auto source .envrc file
  programs.direnv = {
    enable = true;
  };

  # nicer looking git diffs
  programs.delta.enable = true;

  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza";
      ll = "eza -la";
      y = "yazi";
      h = "hx";
      lg = "lazygit";
      vim = "nvim";
      zed = "zeditor";
      nrs = "sudo nixos-rebuild switch --flake .#fw13";
      hms = "home-manager switch --flake .#tim@fw13";
      lt = "eza -la --tree --level=2";
      c = "clear";
      copy = "wl-copy";
      paste = "wl-paste -n";
      rgi = "rg -i";
      ff = "fd -H";
      t = "tmux";
    };
    shellAbbrs = {
      gco = "git checkout";
      gc = "git commit";
      gp = "git push";
      gst = "git status";
      k = "kubectl";
      kgp = "kubectl get pods -A";
      kgn = "kubectl get ns";
      dexauth = "set -x AUTHORIZATION \"Bearer \"(az account get-access-token --resource https://cognitiveservices.azure.com/ --query accessToken -o tsv)";
    };
  };

  # programs.zsh = {
  #   # This should be set to true, even if it is set to configuration.nix.
  #   enable = true;

  #   autocd = true;
  #   autosuggestion.enable = true;
  #   enableCompletion = true;
  #   syntaxHighlighting.enable = true;

  #   # Save zsh config files here.
  #   # FIXME: Will be deprecated.
  #   dotDir = ".config/zsh";

  #   # Add my zsh aliases. Requires `eza`.
  #   shellAliases = {
  #     ga = "git add";
  #     gs = "git status";
  #     gc = "git commit";
  #     gp = "git push";
  #     gP = "git pull";
  #     gl = "git log";
  #     k = "kubectl";
  #     kc = "kubectl ctx";
  #     kn = "kubectl ns";
  #     ls = "eza";
  #     ll = "eza -la";
  #     y = "yazi";
  #     h = "hx";
  #     lg = "lazygit";
  #     vim = "nvim";
  #     zed = "zeditor";
  #   };
  #   # This should help being able to use git within devcontainers withou
  #   # running this command manually.
  #   initContent = ''
  #           ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'
  #           # ssh-add $HOME/.ssh/id_rsa > /dev/null 2>&1 &
  #     			PATH=/usr/local/bin:/usr/local/share:$PATH
  #           export EDITOR="nvim"
  #   '';
  # };

}

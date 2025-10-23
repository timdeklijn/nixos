{ pkgs }:
{
  # Startship prompt looks nice
  programs.starship.enable = true;

  # zoxide for faster jumping to and from folders
  programs.zoxide = {
    enable = true;
    package = pkgs.unstable.zoxide; # or pkgs.zoxide, but pick one
  };

  # search through history
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # auto source .envrc file
  programs.direnv.enable = true;

  # nicer looking git diffs
  programs.git.delta.enable = true;
  programs.zsh = {
    # This should be set to true, even if it is set to configuration.nix.
    enable = true;

    autocd = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    # Save zsh config files here.
    # FIXME: Will be deprecated.
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
      y = "yazi";
      s = "subl";
      zed = "zeditor";
    };
    # This should help being able to use git within devcontainers withou
    # running this command manually.
    # NOTE: this does not work...
    initContent = ''
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'
      # ssh-add $HOME/.ssh/id_rsa > /dev/null 2>&1 &
    '';
  };

}

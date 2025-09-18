{ pkgs }:
{
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
}

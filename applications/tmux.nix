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
      {
        plugin = pkgs.tmuxPlugins.dracula;
        extraConfig = ''
          set -g @dracula-refresh-rate 10
          set -g @dracula-show-powerline true

          set -g @dracula-show-battery true

          set -g @dracula-show-network false

          set -g @dracula-show-cpu true

          set -g @dracula-cpu-display-load true
          set -g @dracula-cpu-usage-label " "

          set -g @dracula-show-weather false
          # set -g @dracula-show-fahrenheit false
          # set -g @dracula-show-location false

        '';
      }
    ];
    extraConfig = ''
      set-option -g status-position bottom

      # reload config
      bind r source-file ~/.config/tmux/tmux.conf\; display "Reloaded!"

      # remap split panes
      bind | split-window -h
      bind _ split-window -v

      # vim style through resizing
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      set -g default-terminal "tmux-256color"
    '';
  };
}

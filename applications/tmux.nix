{ pkgs }:
{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    historyLimit = 100000;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    sensibleOnTop = true;
    escapeTime = 1;
    baseIndex = 0;
    extraConfig = ''
      # reload config
      bind r source-file ~/.config/tmux/tmux.conf\; display "Reloaded!"

      # remap split panes
      bind | split-window -h -c "#{pane_current_path}"
      bind _ split-window -v -c "#{pane_current_path}"

      # select pane by pressing `<C-a>-hjkl`
      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R

      # vim style through resizing
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      set -g status-style "bg=default fg=colour10"
      set -g status-left-length 40
      set-option -g status-position top

      # Toggle last window
      bind-key -r o last-window
      # open `tmux-sessionizer` in a pop-up window.
      bind-key C-f display-popup -E "tms"
    '';
  };
}

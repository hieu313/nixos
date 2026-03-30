{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.tmux = {
    enable = true;

    # --- Native options (instead of writing raw config) ---
		# Reference: ../../config/tmux/tmux.conf (JUST FOR REFERENCE, NOT USED)
    terminal = "tmux-256color";
    prefix = "C-a";
    keyMode = "vi";
    mouse = true;
    historyLimit = 10000;
    shell = "${pkgs.zsh}/bin/zsh";
    escapeTime = 10;

    # --- Plugins ---
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-powerline true
          set -g @dracula-fixed-location "NYC"
          set -g @dracula-plugins "time"
          set -g @dracula-show-flags true
          set -g @dracula-show-left-icon session
        '';
      }
    ];

    extraConfig = ''
      # True color support
      set -ag terminal-overrides ",xterm-256color:RGB"

      # Remap prefix từ C-b sang C-a
      unbind C-b
      bind-key C-a send-prefix

      # Split panes
      unbind %
      bind | split-window -h
      unbind '"'
      bind - split-window -v

      # Reload config
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      # Resize panes
      bind j resize-pane -D 5
      bind k resize-pane -U 5
      bind l resize-pane -R 5
      bind h resize-pane -L 5
      bind -r m resize-pane -Z

      # Status bar
      set -g status-position bottom

      # Vi copy mode bindings
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection
      unbind -T copy-mode-vi MouseDragEnd1Pane
    '';
  };
}
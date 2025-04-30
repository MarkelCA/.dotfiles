{ _, pkgs, ... }:

{
  programs.fzf.tmux.enableShellIntegration = true;
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    mouse = true;
    prefix = "C-b";
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";

    # Vim style pane selection
    customPaneNavigationAndResize = true;

    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set-option -g allow-passthrough on

      # Use Alt-arrow keys without prefix key to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Shift arrow to switch windows
      bind -n S-Left previous-window
      bind -n S-Right next-window

      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # split panes using | and - and open in current path
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # Vi-style copy mode bindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
    '';

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = sensible;
      }
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_text "#W"
          set -g @catppuccin_window_current_text "#W"

          set -g @catppuccin_status_modules_right "application session"
        '';
      }
      {
        plugin = yank;
      }
      {
        plugin = cpu;
      }
      {
        plugin = battery;
      }
    ];
  };
}

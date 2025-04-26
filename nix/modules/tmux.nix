{ _, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    mouse = true;
    prefix = "C-b";
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";

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

      # set vi-mode
      set-window-option -g mode-keys vi

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
        extraConfig = "";
      }
      {
        plugin = vim-tmux-navigator;
        extraConfig = "";
      }
      {
        plugin = catppuccin;
        extraConfig = ''
          # Set Catppuccin theme flavor
          set -g @catppuccin_flavour 'mocha'
        '';
      }
      {
        plugin = yank;
        extraConfig = "";
      }
      # TPM is not needed in Nix as plugins are managed declaratively
    ];

    # Vim style pane selection
    customPaneNavigationAndResize = true;
  };
  programs.fzf.tmux.enableShellIntegration = true;
}

{ config, pkgs, lib, ... }:

{
  # Install Neovim via home-manager
  programs.neovim = {
    enable = true;
  };

  # Prevent home-manager from managing the nvim config directory
  xdg.configFile."nvim".enable = false;

  # Clone your Neovim config repository directly to ~/.config/nvim if it doesn't exist
  home.activation = {
    cloneNeovimConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ ! -d "$HOME/.config/nvim" ]; then
        ${pkgs.git}/bin/git clone https://github.com/markelca/nvim.git $HOME/.config/nvim
        echo "Neovim config repository cloned to ~/.config/nvim"
      else
        echo "~/.config/nvim already exists, skipping clone"
      fi
    '';
  };
}

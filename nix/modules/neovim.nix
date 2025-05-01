# The idea is to symlink dotfiles/nvim into .config/nvim,
# because I don't want nix to manage my nvim config. LazyVim does it.
{ pkgs, config, ... }: {

  programs.neovim = { enable = true; };

  home.packages = with pkgs; [ lua-language-server prettierd ];

  # Use the external dotfiles nvim config for quicker hacking
  home.file.".config/nvim" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/nvim";
  };
}

{ _, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };

    initExtra = ''
      bindkey -M emacs '^P' history-substring-search-up
      bindkey -M emacs '^N' history-substring-search-down

      eval "$(zoxide init zsh)"
    '';

    plugins = [
      # For plugins not included in oh-my-zsh, you can add them here
      # You'll need to install these plugins separately or use Nix packages
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "5eb677bb0fa9a3e60f0eff031dc13926e093df92";
          sha256 = "sha256-KRsQEDRsJdF7LGOMTZuqfbW6xdV5S38wlgdcCM98Y/Q=";
        };
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "0e810e5afa27acbd074398eefbe28d13005dbc15";
          sha256 = "sha256-85aw9OM2pQPsWklXjuNOzp9El1MsNb+cIiZQVHUzBnk=";
        };
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "87ce96b1862928d84b1afe7c173316614b30e301";
          sha256 = "sha256-1+w0AeVJtu1EK5iNVwk3loenFuIyVlQmlw8TWliHZGI=";
        };
      }
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "2abe1f2f1cbcb3d3c6b879d849d683de5688111f";
          sha256 = "sha256-zc9Sc1WQIbJ132hw73oiS1ExvxCRHagi6vMkCLd4ZhI=";
        };
      }
    ];

    sessionVariables = { PATH = "~/.npm-global/bin:$PATH"; };

    shellAliases = {
      # Git aliases
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gca = "git add . && git commit";
      gp = "git push";
      gr = "git restore";
      grs = "git restore --staged";
      gd = "git diff";
      gl = "git log";
      # Kubernetes
      k = "kubectl";
      # Clipboard
      xclip = "xclip -selection clipboard";
      # Zoxide (better cd)
      cd = "z";
      # Eza (better ls)
      e = "eza --icons=always $@";
      et = "eza --tree --icons=always $@";
      m = "make";
    };
  };

  # Configure zoxide
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Add Go binaries to PATH
  home.sessionPath = [ "$HOME/go/bin" ];
}

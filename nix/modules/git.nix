{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.delta
  ];

  programs.git = {
    enable = true;
    userName = "Markel Cuesta";
    userEmail = "cuestaarribas.markel@proton.me";

    extraConfig = {
      push = { autoSetupRemote = true; };

      core = {
        editor = "vim";
        excludesFile = "/home/markel/.gitignore_global";
        pager = "delta";
      };

      rerere = {
        enabled = false;
        autoupdate = true;
      };

      alias = {
        co = "checkout";
        ci = "commit";
        st = "status";
        br = "branch -av";
        staash = "stash --all"; # Also stashes untracked files
        bb =
          "!~/bin/better-git-branch.sh"; # More friendly branch list (only local branches)
        pushf = "push --force-with-lease --force-if-includes";
        aliases =
          "!git config --list | grep 'alias\\.' | sed 's/alias\\.\\([^=]*\\)=\\(.*\\)/\\1\\ 	 => \\2/' | sort";
        lg =
          "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      };

      branch = { sort = "-committerdate"; };

      maintenance = { repo = "/home/markel/.dotfiles"; };

      interactive = { diffFilter = "delta --color-only"; };

      delta = {
        navigate = true;
        side-by-side = true;
      };

      merge = { conflictStyle = "zdiff3"; };
    };
  };
}

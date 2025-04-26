{ config, pkgs, nixGL, ... }:

{
  programs.kitty = {
    enable = true;
    package = pkgs.writeShellScriptBin "kitty" ''
      exec ${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel ${pkgs.kitty}/bin/kitty "$@"
    '';
    font = {
      name = "JetBrainsMono";
      size = 16.0;
    };
  };
}

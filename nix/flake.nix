{
  description = "Home Manager configuration of markel";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixGL, ... }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ nixGL.overlay ];
      };
    in {
      homeConfigurations = {
        # Original configuration
        "markel" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { 
            inherit nixGL;
            profileName = "personal";
          };
          modules = [ ./home.nix ];
        };
        
        "work" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { 
            inherit nixGL;
            profileName = "work";
          };
          modules = [ ./home.nix ];
        };
      };
    };
}

{
  description = "Home Manager configuration of paul";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm = {
      url = "github:wez/wezterm?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    wezterm,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    wt = wezterm.packages.${system}.default;
  in {
    homeConfigurations."paul" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [./home.nix];
      extraSpecialArgs = {
        wezterm = wt;
      };

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  };
}

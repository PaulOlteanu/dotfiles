{
  description = "Home Manager configuration of paul";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm = {
      url = "github:wez/wezterm/a082117bb800ca00f4c333cc7d25660484eb24ac?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #  };
  };

  outputs = {
    nixpkgs,
    home-manager,
    wezterm,
    # hyprland,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations."paul" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [./home.nix];

      extraSpecialArgs = let
        wt = wezterm.packages.${system}.default;
        # h = hyprland.packages.${system}.default;
      in {
        wezterm = wt;
        # hyprland = h;
      };

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  };
}

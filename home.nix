{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "paul";
  home.homeDirectory = "/home/paul";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ./modules/desktop

    ./alacritty.nix
    ./starship.nix
    ./git.nix
    ./wezterm.nix
    # ./zellij.nix
    ./helix.nix
    ./vscode.nix
  ];

  modules.desktop.enable = true;

  nixpkgs.config.allowUnfree = true;
  # TODO: Configure through home manager
  programs.neovim.enable = true;

  programs.fish.enable = true;
  programs.eza.enable = true;
  programs.fd.enable = true;
  programs.ripgrep.enable = true;
  programs.jq.enable = true;
  programs.zoxide.enable = true;
  programs.fzf = {
    enable = true;
    enableFishIntegration = false;
    enableBashIntegration = false;
    enableZshIntegration = false;
  };
  programs.atuin = {
    enable = true;
    flags = ["--disable-up-arrow"];
    settings = {
      enter_accept = false;
    };
  };
  programs.tealdeer.enable = true;


  programs.k9s.enable = true;
  programs.lazygit.enable = true;

  programs.ruff.enable = true;
  programs.ruff.settings = {};

  home.packages = with pkgs; [
    cachix

    (pkgs.python3Packages.callPackage ./packages/shyaml.nix {})
    (pkgs.callPackage ./packages/flamegraph.nix {})

    awscli2 # TODO: Configure through home manager
    oci-cli
    kubernetes

    rustup

    nodePackages.pyright
    nodePackages.typescript-language-server
    black
    nil
    alejandra
    taplo

    playerctl
    spotify
    discord
  ];

  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

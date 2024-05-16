{
  lib,
  config,
  pkgs,
  hyprland,
  ...
}:
with lib; let
  cfg = config.modules.desktop;
in {
  imports = [
    ./hyprland.nix
    # ./sway.nix
    ./waybar.nix
  ];

  options = {
    modules.desktop.enable = mkEnableOption "desktop environment";
  };

  config = mkIf cfg.enable {
    gtk = {
      enable = true;

      theme = {
        name = "Arc-Dark";
        package = pkgs.arc-theme;
      };

      cursorTheme = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      font = {
        name = "Public Sans";
        size = 12;
        package = pkgs.public-sans;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-button-images = 1;
        gtk-menu-images = 1;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintfull";
        gtk-xft-rgba = "rgb";
      };
    };

    fonts.fontconfig.enable = true;

    services.playerctld.enable = true;
    services.udiskie.enable = true;
    services.swaync.enable = true;
    services.hyprpaper.enable = true;

      services.hyprpaper.settings = {
      preload = "/home/paul/Pictures/Penguin.png";
      wallpaper = ",/home/paul/Pictures/Penguin.png";
      splash = false;
    };

    xdg.portal.enable = true;
    xdg.portal.xdgOpenUsePortal = true;
    xdg.portal.configPackages = [
      hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];

    home.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      jetbrains-mono
      public-sans
      (nerdfonts.override {fonts = ["JetBrainsMono"];})

      # Other ====================================================================
      cinnamon.nemo-with-extensions
      cinnamon.nemo-fileroller
      gnome.file-roller
      gnome.dconf-editor
      pavucontrol
      helvum
      wl-clipboard
      pantheon.pantheon-agent-polkit

      gnome.adwaita-icon-theme
      papirus-icon-theme
      arc-theme
      xdg-desktop-portal-gtk
      glib
      gsettings-desktop-schemas
      xdg-utils

      # TODO: Configure though home manager. These have config options
      waybar
      rofi-wayland
    ];
  };
}

{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.sway.enable = true;
  wayland.windowManager.sway.extraOptions = [
    "--unsupported-gpu"
  ];
}

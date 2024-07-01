{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  options.settings.wayfire = {
    enable = lib.mkEnableOption "WayfireWM";
  };

  config = lib.mkIf (config.settings.wayfire.enable) {
    home.packages = [
      (pkgs.wayfire-with-plugins.override {
        wayfire = pkgs.wayfire;
        plugins = with pkgs.wayfirePlugins; [ ];
      })
    ];
  };
}

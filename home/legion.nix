{
  config,
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}: {
  imports = [
    ./.
  ];

  settings = {
    monitors = [
      {
        name = "eDP-1";
        wallpaper = ./wallpapers/wall3.jpg;
      }
    ];
    desktop.enable = true;
    nix.unfree = [
      "1password"
      "1password-gui"
    ];
  };
  wayland.windowManager.hyprland.settings.input.kb_options = lib.mkForce "ctrl:nocaps,altwin:swap_lalt_lwin,altwin:prtsc_rwin";
  home.shellAliases = {
    bat-fullcharge = "sudo tlp fullcharge";
    bat-limit = "sudo tlp setcharge 0 1 BAT0";
    bt = "bluetooth";
  };
  home.packages = with pkgs; [
    _1password-gui-beta
  ];
}

{
  config,
  lib,
  pkgs,
  inputs,
  globalSettings,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../.
    ../config/asahi # This causes problems when imported globally
  ];

  settings = {
    asahi.enable = true;
    greeter.enable = true;
    xserver.xwayland.enable = true;
    locale = {
      main = "en_US.UTF-8";
      other = "nb_NO.UTF-8";
      timeZone = "Europe/Oslo";
    };
    user.name = globalSettings.username;
    # user.shell = pkgs.fish;
    user.shell = pkgs.zsh;
    networking = {
      enable = true;
      hostname = "nixos-mac";
      wifi.enable = true;
      bluetooth.enable = true;
    };
    utils.enable = true;
    tlp.enable = false;
    console = {
      font = "ter-u32n";
      keyMap = "no";
    };
    sops.enable = true;
  };

  # Enable XDG-desktop-portals (TODO: I think it's possible to do this in home)
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    configPackages = [pkgs.xdg-desktop-portal-gtk];
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}

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
        geometry = "1920x1080@60";
        position = "0x0";
      }
    ];
    desktop.enable = true;
    nix.unfree = [
      "1password"
      "1password-gui"
    ];
    wm.hyprland.monitors.enable = true;
    wm.hyprland.useFlake = true;

    gaming.enable = true;
    gaming.steam.enable = true;
  };
  wayland.windowManager.hyprland.settings.input = {
    kb_options = "ctrl:nocaps,altwin:prtsc_rwin";
  };
  home.shellAliases = {
    bat-fullcharge = "sudo tlp fullcharge";
    bat-limit = "sudo tlp setcharge 0 1 BAT0";
    bt = "bluetooth";
    osbuild = let
      base_cmd = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/dotfiles";
    in
      (pkgs.writeShellScript "osbuild" ''
        #!/usr/bin/env bash
        if [ -z "''${NIXOS_ACTIVE_SPECIALISATION}" ] || [ "''${NIXOS_ACTIVE_SPECIALISATION}" = "default" ]; then
            ${base_cmd}
        else
            ${base_cmd} --specialisation "''${NIXOS_ACTIVE_SPECIALISATION}"
        fi
      '')
      .outPath;
  };
  home.packages = with pkgs; [
    _1password-gui-beta
    protonvpn-gui
  ];

  home.file."my-super-secret-secret.txt".text = inputs.secrets.test;
  sops.secrets."ssh/legion".path = "${config.home.homeDirectory}/.ssh/id_ed25519";
  home.file.".ssh/id_ed25519.pub".text = inputs.secrets.ssh.legion.public;
}

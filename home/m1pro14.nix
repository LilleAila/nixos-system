{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [./.];

  # https://github.com/tinted-theming/base16-schemes/
  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
  settings = {
    monitors = [
      {
        name = "eDP-1";
        width = 3024;
        height = 1890;
        refreshRate = 60;
        x = 0;
        y = 0;
        scale = 2;
        enable = true;
        wallpaper = ./wallpapers/wall3.jpg;
      }
      {
        name = "HDMI-A-1";
        width = 2560;
        height = 1440;
        refreshRate = 144;
        x = -524;
        y = -1440;
        scale = 1;
        enable = true;
        wallpaper = ./wallpapers/wall18.jpg;
      }
    ];
    qt.enable = true;
    gtk.enable = true;
    wm = {
      ags.enable = true;
      hyprland = {
        enable = true;
        # useLegacyRenderer = true;
        screenshots.enable = true;
      };
      avizo.enable = true;
      hypridle.enable = true;
      hyprlock.enable = true;
      hyprpaper.enable = true;
      mako.enable = true;
      wlogout.enable = true;
    };
    files = {
      nemo.enable = true;
      thunar.enable = false;
    };
    zathura.enable = true;
    browser = {
      firefox.enable = true;
    };
    discord = {
      enable = true;
      hyprland.enable = true;
    };
    emacs.enable = true;
    terminal = {
      zsh = {
        enable = true;
        theme = "nanotech";
      };
      fish = {
        enable = true;
      };
      utils.enable = true;
      emulator = {
        enable = true;
        name = "kitty";
      };
      neovim.enable = true;
    };
    imageviewer.enable = true;
    other.enable = true;
  };

  # Local shell aliases
  home.shellAliases = {
    bat-fullcharge = "echo 100 | sudo tee /sys/class/power_supply/macsmc-battery/charge_control_end_threshold";
    bat-limit = "echo 80 | sudo tee /sys/class/power_supply/macsmc-battery/charge_control_end_threshold";
  };
}

{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkDefault mkIf;
  cfg = config.settings.desktop;
in {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./wm
    ./programs
  ];

  options.settings.desktop.enable = mkEnableOption "Default desktop configuration";

  config = mkIf cfg.enable {
    # https://github.com/tinted-theming/base16-schemes/
    colorScheme = mkDefault inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
    settings = {
      gtk.enable = mkDefault true;
      qt.enable = mkDefault true;
      cursor = {
        size = mkDefault 24;
        package = mkDefault (inputs.nix-cursors.packages.${pkgs.system}.bibata-original-cursor.override {
          background_color = "#${config.colorScheme.palette.base00}";
          outline_color = "#${config.colorScheme.palette.base06}";
          accent_color = "#${config.colorScheme.palette.base00}";
          replace_crosshair = true;
        });
        name = mkDefault "Bibata-Original-Custom";
      };

      fcitx5.enable = mkDefault true;
      wm = {
        ags.enable = mkDefault true;
        hyprland.enable = mkDefault true;
        sway.enable = mkDefault false;
        avizo.enable = mkDefault true;
        hypridle.enable = mkDefault true;
        swaylock.enable = mkDefault true;
        hyprlock.enable = mkDefault false;
        hyprpaper.enable = mkDefault true;
        mako.enable = mkDefault false;
        wlogout.enable = mkDefault false;
      };

      files.nemo.enable = mkDefault true;
      files.thunar.enable = mkDefault false;

      zathura.enable = mkDefault true;
      browser.firefox.enable = mkDefault true;
      browser.firefox.newtab_image = mkDefault ../../wallpapers/wall1.png;
      browser.qutebrowser.enable = mkDefault true;

      discord.vesktop.enable = mkDefault true;
      discord.dissent.enable = mkDefault false;

      emacs.enable = mkDefault false;

      terminal = {
        zsh.enable = mkDefault true;
        zsh.theme = mkDefault "nanotech";
        fish.enable = mkDefault false;
        utils.enable = mkDefault true;
        emulator.enable = mkDefault true;
        emulator.name = mkDefault "kitty";
        neovim.enable = mkDefault true;
      };

      imageviewer.enable = mkDefault true;
      other.enable = mkDefault true;

      fonts = let
        jetbrains_nerd = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
      in {
        serif.package = mkDefault pkgs.dejavu_fonts;
        serif.name = mkDefault "DejaVu Serif";
        sansSerif.package = mkDefault pkgs.dejavu_fonts;
        sansSerif.name = mkDefault "DejaVu Sans";
        monospace.package = mkDefault jetbrains_nerd;
        monospace.name = mkDefault "JetBrainsMono Nerd Font";
        nerd.package = mkDefault jetbrains_nerd;
        nerd.name = mkDefault "JetBrainsMono Nerd Font";
        size = mkDefault 10;
      };
    };

    settings.webapps.chromium = {
      Monkeytype = {
        icon = mkDefault "input-keyboard-symbolic";
        url = mkDefault "https://monkeytype.com";
      };
    };
  };
}
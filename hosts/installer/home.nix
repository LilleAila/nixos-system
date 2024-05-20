{
  config,
  pkgs,
  inputs,
  lib,
  keys,
  ...
}: {
  imports = [../../home];

  # https://github.com/tinted-theming/base16-schemes/
  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
  settings = {
    # emacs.enable = true;
    terminal = {
      zsh = {
        enable = true;
        theme = "nanotech";
      };
      utils.enable = true;
      neovim.enable = true;
    };
  };
  home.username = lib.mkForce "nixos";
  sops.secrets."ssh/installer".path = "${config.home.homeDirectory}/.ssh/id_ed25519";
  home.file.".ssh/id_ed25519.pub".text = keys.ssh.installer.public;
  home.file.".config/sops/age/keys.txt".source = ../../secrets/sops-key.txt;
  home.file."install.sh" = {
    source = ../../install.sh;
    executable = true;
  };
}

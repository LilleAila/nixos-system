/*
https://nixos.wiki/wiki/Syncthing
https://wes.today/nixos-syncthing

The folder.<name>.enable option has to be set to true for the folders to actually sync.
I think that is better to do per-system instead of globally
Also note that the devices defined here depend on my secrets private GitHub repo.
*/
{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  username = config.settings.user.name;
  homePath = "/home/${username}";
  secrets = inputs.secrets.syncthing;
in {
  options.settings.syncthing.enable = lib.mkEnableOption "Syncthing";

  config = lib.mkMerge [
    (lib.mkIf config.settings.syncthing.enable {
      # Config panel at http://127.0.0.1:8384/
      # Go to the config panel to find the device ID
      services.syncthing = {
        enable = true;
        user = username;
        dataDir = "/home/${username}";
        configDir = "/home/${username}/.config/syncthing";
        openDefaultPorts = true;
        overrideDevices = true;
        overrideFolders = true;
        settings = {
          gui = {
            user = "${username}";
            password = "${secrets.password}";
          };
          devices = {
            legion = {id = "${secrets.ids.legion}";};
          };
          folders = {
            "Default Folder" = {
              path = "${homePath}/Sync";
              devices = ["legion"];
            };
            "Factorio" = {
              path = "${homePath}/factorio";
              devices = ["legion"];
              ignorePerms = false; # executable permissions and stuff
            };
            "Notes" = {
              path = "${homePath}/org";
              devices = ["legion"];
            };
          };
        };
      };
    })
  ];
}
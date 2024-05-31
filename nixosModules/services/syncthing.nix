/*
https://nixos.wiki/wiki/Syncthing
https://wes.today/nixos-syncthing
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
  options.settings.syncthing.enableAllFolders = lib.mkEnableOption "Syncthing";

  config = lib.mkMerge [
    (lib.mkIf config.settings.syncthing.enableAllFolders {
      # FIXME: 1. all folders get enabled by default, so this is unnecessary
      #        2. folders are created automatically even if the computer is not listed for said folder
      services.syncthing.settings.folders = {
        "Default Folder".enable = lib.mkDefault true;
        "Factorio".enable = lib.mkDefault true;
        "Notes".enable = lib.mkDefault true;
        "Minecraft".enable = lib.mkDefault true;
      };
    })
    (lib.mkIf config.settings.syncthing.enable {
      # Config panel at http://127.0.0.1:8384/
      # Go to the config panel to find the device ID
      # TODO: configure syncthing keys and certs for different computers using sops
      services.syncthing = {
        enable = true;
        user = username;
        dataDir = "/home/${username}";
        configDir = "/home/${username}/.config/syncthing";
        openDefaultPorts = true;
        overrideDevices = true;
        overrideFolders = true;
        settings = {
          options = {
            # TODO: maybe set up my own relay, but i can't find any nix options for custom relays
            urAccepted = -1; # Don't submit usage data
            relaysEnabled = true;
          };
          gui = {
            user = "${username}";
            password = "${secrets.password}";
          };
          devices = {
            legion = {id = "${secrets.ids.legion}";};
            mac = {id = "${secrets.ids.mac}";};
            t420 = {id = "${secrets.ids.t420}";};
            oci = {id = "${secrets.ids.oci}";};
            e14g5 = {id = "${secrets.ids.e14g5}";};
          };
          folders = {
            "Default Folder" = {
              path = "${homePath}/Sync";
              devices = ["oci" "legion" "mac" "t420" "e14g5"];
            };
            "Factorio" = {
              path = "${homePath}/factorio";
              devices = ["oci" "legion" "mac" "e14g5"];
              ignorePerms = false; # executable permissions and stuff
            };
            "Notes" = {
              path = "${homePath}/org";
              devices = ["oci" "legion" "mac" "t420" "e14g5"];
            };
            "Minecraft" = {
              path = "${homePath}/.local/share/PrismLauncher/instances";
              devices = ["oci" "legion" "mac" "e14g5"];
            };
          };
        };
      };
    })
  ];
}

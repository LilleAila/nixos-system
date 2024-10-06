{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
{
  options.settings.calibre-web.enable = lib.mkEnableOption "calibre-web";

  config = lib.mkIf config.settings.calibre-web.enable {
    sops.secrets."tunnels/calibre" = {
      owner = "cloudflared";
      group = "cloudflared";
    };

    services.cloudflared.tunnels.${(import ../../secrets/tokens.nix).calibre.id} = {
      credentialsFile = config.sops.secrets."tunnels/calibre".path;
      default = "http_status:404";
      ingress = {
        "calibre.olai.dev" = "http://${config.services.calibre-web.listen.ip}:${toString config.services.calibre-web.listen.port}";
      };
    };

    services.calibre-web = {
      enable = true;
      listen = {
        ip = "127.0.0.1";
        port = 8083;
      };
      dataDir = "calibre-web"; # /var/lib/calibre-web
    };
  };
}

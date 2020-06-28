{ config, lib, pkgs,
  nix-notes-version,
  ... }:
{
  options = {
    noteed-com.additional-locations = lib.mkOption {
      default = {};
      description = "Additional Nginx locations for the noteed.com virtual host.";
    };
  };
  config = {
    services.nginx = {
      enable = true;
      virtualHosts."noteed.com" = {
        forceSSL = true;
        enableACME = true;
        inherit (import ./vhost.nix {
          inherit pkgs nix-notes-version ;
          additional-locations = config.noteed-com.additional-locations; }) locations;
      };
    };

    security.acme.acceptTerms = true;
    security.acme.certs = {
      "noteed.com".email = "noteed@gmail.com";
    };
  };
}

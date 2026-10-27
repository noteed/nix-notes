{ config, lib, pkgs,
  nix-notes-version,
  ... }:
{
  services.nginx = {
    enable = true;
    virtualHosts."noteed.com" = {
      forceSSL = true;
      enableACME = true;
      inherit (import ./vhost.nix { inherit pkgs nix-notes-version; }) locations;
    };
  };

  security.acme.acceptTerms = true;
  security.acme.certs = {
    "noteed.com".email = "noteed@gmail.com";
  };
}

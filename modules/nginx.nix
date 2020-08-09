{ config, lib, pkgs,
  nix-notes-version,
  ... }:
{
  services.nginx = {
    enable = true;
    virtualHosts."noteed.com" = {
      locations = {
        "/nix-notes/".alias = (import ./site).html.all + "/";
        "~ ^/$".extraConfig = ''
          return 200 'noteed.com';
        '';
      };
    };
  };
}

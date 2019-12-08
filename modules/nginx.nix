{ config, lib, pkgs,
  nix-notes-version,
  ... }:
{
  services.nginx = {
    enable = true;
    virtualHosts."noteed.com" = {
      locations = {
        "~ ^/$".extraConfig = ''
          return 200 'noteed.com';
        '';
      };
    };
  };
}

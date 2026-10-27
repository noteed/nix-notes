{ config, lib, pkgs,
  nix-notes-version,
  ... }:
{
  imports = [
    modules/app.nix
    modules/base.nix
    modules/cron.nix
    modules/nginx.nix
    modules/ssmtp.nix
  ];

  system.stateVersion = "26.05";
}

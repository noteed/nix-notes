{ config, lib, pkgs,
  nix-notes-version,
  ... }:
{
  systemd.services.app = {
    wantedBy = [ "multi-user.target" ];
    script = "${import ../app}/bin/app";
  };
}

{ config, lib, pkgs,
  nix-notes-version,
  ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/5 * * * * root date >> /tmp/cron.log"
    ];
  };
}

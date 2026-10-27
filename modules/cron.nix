{ config, lib, pkgs,
  nix-notes-version,
  ... }:
{
  services.cron = {
    enable = true;
    # This amount to about 8.5MB in 3 years.
    systemCronJobs = [
      "*/5 * * * * root date >> /tmp/cron.log"
    ];
  };
}

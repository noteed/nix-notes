{ config, lib, pkgs,
  nix-notes-version,
  ... }:
{
  services.ssmtp = {
    enable = true;
    hostName = "smtp.fastmail.com:465";
    domain = "noteed.com";
    useTLS = true;
    authUser = "thu@fastmail.com";
    authPassFile = "/run/keys/ssmtp-authpass";
    setSendmail = true;
  };
}

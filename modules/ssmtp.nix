{ config, lib, pkgs,
  nix-notes-version,
  ... }:
{
  # This doens't seem to longer exist in 19.09.
  #services.ssmtp = {
  #  enable = true;
  #  hostName = "smtp.fastmail.com:465";
  #  domain = "noteed.com";
  #  useTLS = true;
  #  authUser = "thu@fastmail.com";
  #  authPassFile = "/run/keys/ssmtp-authpass";
  #  setSendmail = true;
  #};
}

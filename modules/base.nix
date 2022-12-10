{ config, lib, pkgs,
  nix-notes-version,
  ... }:
{
  services.sshd.enable = true;

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  users.users.root.password = "nixos";
  services.openssh.permitRootLogin = lib.mkDefault "yes";
  services.getty.autologinUser = lib.mkDefault "root";
}

{ config, lib, pkgs,
  nix-notes-version,
  ... }:
{
  services.sshd.enable = true;

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  users.users.root.password = "nixos";
  services.openssh.settings.PermitRootLogin = lib.mkDefault "yes";
  services.getty.autologinUser = lib.mkDefault "root";
}

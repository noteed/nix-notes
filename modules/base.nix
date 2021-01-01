{ config, lib, pkgs,
  nix-notes-version,
  ... }:
{
  services.sshd.enable = true;

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  users.users.root.password = "nixos";
  services.openssh.permitRootLogin = lib.mkDefault "yes";
  services.mingetty.autologinUser = lib.mkDefault "root";
}

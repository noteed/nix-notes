{ config, lib, pkgs, ... }:
{
  services.sshd.enable = true;

  networking.firewall.allowedTCPPorts = [ 80 ];

  users.users.root.password = "nixos";
  services.openssh.permitRootLogin = lib.mkDefault "yes";
  services.mingetty.autologinUser = lib.mkDefault "root";

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

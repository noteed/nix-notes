{ config, lib, pkgs,
  nix-notes-version,
  ... }:
{
  services.sshd.enable = true;

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  users.users.root.password = "nixos";
  services.openssh.permitRootLogin = lib.mkDefault "yes";
  services.mingetty.autologinUser = lib.mkDefault "root";

  services.nginx = {
    enable = true;
    virtualHosts."noteed.com" = {
      forceSSL = true;
      enableACME = true;
      inherit (import ./vhost.nix { inherit pkgs nix-notes-version; }) locations;
    };
  };

  security.acme.certs = {
    "noteed.com".email = "noteed@gmail.com";
  };

  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/5 * * * * root date >> /tmp/cron.log"
    ];
  };

  systemd.services.app = {
    wantedBy = [ "multi-user.target" ];
    script = "${import ./app}/bin/app";
  };

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

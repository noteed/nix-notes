{ config, lib, pkgs,
  nix-notes-version,
  ... }:
{
  imports = [ ./gitolite.nix ];
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

  services.mygitolite = {
    enable = true;
    user  = "git";
    group = "git";
    adminPubkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC9pA/P3A72o7wCs40rPo4kr91c8OokgJhH0LxKBF0EmiLjY++8Nh3t7avo88fJI86dkBR4SkdmAG+elicNwQc/n7iN4zMOs8Cdbye/ZrN4xoI5OHyAz1OjzYY6Lje0tuFYrQa8XxW3GF6cWVOLE/v6ShlIoUL1QPrwygdREVhh+as4DhJ6G+4qcjQMMSWw9IPIwpKV+Q8TycTVfL/rDnzzadkp5aPmPgpUhXo8mjY0CY7hGxOpmuPDmyEej8aOTl5fR4yyuz/12lglNNCm8UDu8zJbMOKvvyVWQiXoxmnNFg7lAUU/FcLla0JbQx+4szPHfUgqJNYKyoxdGktmx0FvKavPK5df70ezwEnBAqhHauHDu52GsrCSH8ZItgxvts2CowP52X+GDaWsVtNgXOsu2+1FODog/wVHjOadKBOsp0w6tXsf5zcfysANeSHgB79zyAg4NaJ8UpD0g9qdbhzX5zOJ3JCeA/J+ulnHdegRZSbeXlhTCsvAJygHF74RWx0Bcdr1SiUgOj51Wl9aTERgM7wIykHOvEv38T3ZYw7ZVVsV2atcWdqCOsT9OhVOdO5nqgS8Yh3maHoP9fwKoxNZGF650KIl927GQ7l2DKH8aWhqxhxMagtj4zKimpCEUMUQNJFzOQbi9jL5ri9yUA1FqWlCnxc65MTVWQ8FdPp0LQ== thu on tank";
    extraGitoliteRc = ''

    '';
  };
}

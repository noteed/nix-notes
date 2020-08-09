{ config, lib, pkgs,
  nix-notes-version,
  ... }:
let
  gitcraft = pkgs.fetchFromGitHub {
    owner = "noteed";
    repo = "gitcraft";
    rev = "96bc18ade14dca67da208b0a739f955f611cc2d5";
    sha256 = "17lggp9kf4j288zi71pp0rqbrjzhaqx56x4hbzx8hn04m982riag";
  };
  git-notes = pkgs.fetchFromGitHub {
    owner = "noteed";
    repo = "git-notes";
    rev = "3475e6532ec9c967584183fec7d9aafb2151bd50";
    sha256 = "1mx297l6q353934p1rqp8yc60yjhzd6kca5pjwv9m3hq18gbny7r";
  };
  noteed-github-com = pkgs.fetchFromGitHub {
    owner = "noteed";
    repo = "noteed.github.com";
    rev = "75fa1e634e8b4409910d83c35ddb245349985713";
    sha256 = "1yfkwzrchc8dhzzi8pxx7rsk8l72hv84p6n40rxam5hm8x5pn22p";
  };

in
{
  services.nginx = {
    enable = true;
    virtualHosts."noteed.com" = {
      forceSSL = true;
      enableACME = true;
      inherit (import ./vhost.nix { inherit pkgs nix-notes-version; }) locations;
    };
  };

  security.acme.acceptTerms = true;
  security.acme.certs = {
    "noteed.com".email = "noteed@gmail.com";
  };
}

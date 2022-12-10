{ pkgs,
  nix-notes-version,
  ... }:
let
  nix-notes = import ../site {};
in
rec {
  site = nix-notes.html.all;
  locations = {
    "/add".proxyPass = "http://127.0.0.1:8000";
    "/nix-notes/".alias = nix-notes.html.all + "/";
    "/static/".alias = nix-notes.static + "/";
  };
}

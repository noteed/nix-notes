let
  pkgs = import <nixpkgs> {};

in
  pkgs.runCommand "example-0" {} ''
    echo 'Built with Nix.' > $out
  ''

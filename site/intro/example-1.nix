let
  pkgs = import <nixpkgs> {};

in
{
  example-0 = pkgs.runCommand "example-0" {} ''
    echo 'Built with Nix.' > $out
  '';
  example-1 = pkgs.runCommand "example-1" {} ''
    echo 'Built with Nix too.' > $out
  '';
}

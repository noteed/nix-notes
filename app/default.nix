let
  pkgs = import <nixpkgs> {};
  callPackage = pkgs.lib.callPackageWith pkgs.haskell.packages.ghc884;

  f = import ./derivation.nix;
in
  callPackage f { stdenv = pkgs.stdenv; }

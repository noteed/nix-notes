let
  pkgs = import <nixpkgs> {};
  callPackage = pkgs.lib.callPackageWith pkgs.haskell.packages.ghc865;

  f = import ./derivation.nix;
in
  callPackage f { stdenv = pkgs.stdenv; }

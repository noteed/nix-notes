let
  pkgs = import <nixpkgs> {};
  callPackage = pkgs.lib.callPackageWith pkgs.haskell.packages.ghc884;

  f = import ./derivation.nix;
  drv = callPackage f { stdenv = pkgs.stdenv; };
in

pkgs.stdenv.mkDerivation {
  name = "app-env";
  buildInputs = [
  ] ++ drv.env.nativeBuildInputs;
}

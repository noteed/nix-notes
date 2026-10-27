let
  sources = import ../nix/26.05/nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  callPackage = pkgs.lib.callPackageWith pkgs.haskellPackages;

  f = import ./derivation.nix;
  drv = callPackage f { lib = pkgs.lib; };
in

pkgs.stdenv.mkDerivation {
  name = "app-env";
  buildInputs = [
  ] ++ drv.env.nativeBuildInputs;
}

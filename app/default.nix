let
  sources = import ../nix/26.05/nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  callPackage = pkgs.lib.callPackageWith pkgs.haskellPackages;

  f = import ./derivation.nix;
in
  callPackage f { lib = pkgs.lib; }

with import <nixpkgs> {};
{
  html.all = stdenv.mkDerivation {
    name = "nix-notes";
    src  = ./.;
    installPhase = ''
      mkdir -p "$out/"
      cp -a ./*.html "$out/"
    '';
  };
}

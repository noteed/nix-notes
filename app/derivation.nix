{ mkDerivation, base, servant-server, stdenv, warp }:
mkDerivation {
  pname = "app";
  version = "0.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base servant-server warp ];
  description = "Example Servant app";
  license = stdenv.lib.licenses.bsd2;
}

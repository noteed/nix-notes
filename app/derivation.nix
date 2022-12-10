{ mkDerivation, base, lib, servant-server, warp }:
mkDerivation {
  pname = "app";
  version = "0.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base servant-server warp ];
  description = "Example Servant app";
  license = lib.licenses.bsd2;
}

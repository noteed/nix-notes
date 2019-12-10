{ pkgs ? import <nixpkgs> {} }:
let
  app = import ./app;
in

pkgs.dockerTools.buildImage {
  name = "app";
  contents = [ app ];
  config = {
    Cmd = [ "${app}/bin/app" ];
    ExposedPorts = {
      "8000/tcp" = {};
    };
  };
}

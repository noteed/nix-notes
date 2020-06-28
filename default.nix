{ nixpkgs ? <nixpkgs>
, system ? builtins.currentSystem
, configuration ? ./configuration.nix
, nix-notes-version ? "not-given"
}:
let
  pkgs = import nixpkgs {};
in
rec {
  os = import "${toString nixpkgs}/nixos/lib/eval-config.nix" {
    inherit system;
    extraArgs = { inherit nix-notes-version; };
    modules = [
      configuration
      "${toString nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix"
    ];
  };

  qemu = import "${toString nixpkgs}/nixos/lib/eval-config.nix" {
    inherit system;
    extraArgs = { inherit nix-notes-version; };
    modules = [
      configuration
      "${toString nixpkgs}/nixos/modules/virtualisation/qemu-vm.nix"
      modules/vm-nogui.nix
    ];
  };

  # Build with nix-build -A <attr>
  image = os.config.system.build.digitalOceanImage;
  toplevel = os.config.system.build.toplevel;
  app = import ./app;
  site = (import ./vhost.nix { inherit pkgs nix-notes-version; }).site;
  crontab = os.config.environment.etc.crontab;
  runvm = qemu.config.system.build.vm;
  docker = import ./docker.nix;

  path = "${nixpkgs}";
}

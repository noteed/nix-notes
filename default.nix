{ nixpkgs ? <nixpkgs>
, system ? builtins.currentSystem
}:
rec {
  os = import "${toString nixpkgs}/nixos/lib/eval-config.nix" {
    inherit system;
    modules = [
      ./configuration.nix
      "${toString nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix"
    ];
  };

  qemu = import "${toString nixpkgs}/nixos/lib/eval-config.nix" {
    inherit system;
    modules = [
      ./configuration.nix
      "${toString nixpkgs}/nixos/modules/virtualisation/qemu-vm.nix"
      ./vm-nogui.nix
    ];
  };

  # Build with nix-build -A <attr>
  image = os.config.system.build.digitalOceanImage;
  toplevel = os.config.system.build.toplevel;
  app = import ./app;
  site = (import site/default.nix).html.all;
  crontab = os.config.environment.etc.crontab;
  runvm = qemu.config.system.build.vm;
  docker = import ./docker.nix;
}

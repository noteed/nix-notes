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

  # Build with nix-build -A <attr>
  image = os.config.system.build.digitalOceanImage;
}

{ nixpkgs ? <nixpkgs>
}:

let
  pkgs = import nixpkgs {};

  design-system = pkgs.fetchFromGitHub {
    owner = "hypered";
    repo = "design-system";
    rev = "00ec56920f1c86baa5ea0fdf96e5be79ce253fc6";
    sha256 = "04i1hbfvsd068zgrlxgppia9ryxv2l33h00aaj9l0grkcldlkr8c";
  };
  inherit (import design-system {}) to-html;

in rec
{
  md.index = ./index.md;
  md.image = ./image.md;
  md.deploying = ./deploying.md;

  html.index = to-html md.index;
  html.image = to-html md.image;
  html.deploying = to-html md.deploying;
  html.all = pkgs.runCommand "all" {} ''
    mkdir $out
    cp ${html.index} $out/index.html
    cp ${html.image} $out/image.html
    cp ${html.deploying} $out/deploying.html
  '';
}

{ nixpkgs ? <nixpkgs>
, nix-notes-version ? "not-given"
, gitcraft-version ? "not-given"
, git-notes-version ? "not-given"
, noteed-com-version ? "not-given"
}:

let
  pkgs = import nixpkgs {};

  design-system-version = "4d55e94cf514d7e6bd65d6aae537c1d0a798894c";
  design-system = pkgs.fetchFromGitHub {
    owner = "hypered";
    repo = "design-system";
    rev = design-system-version;
    sha256 = "124szwc5mj12pbn8vc9z073bhwhyjgji2xc86jdafpi24d1dsqr4";
  };
  inherit (import design-system {}) template lua-filter replace-md-links static;

  to-html = src: pkgs.runCommand "html" {} ''
    ${pkgs.pandoc}/bin/pandoc \
      --from markdown \
      --to html \
      --standalone \
      --template ${template} \
      -M prefix="" \
      -M font="ibm-plex" \
      --lua-filter ${lua-filter} \
      --output $out \
      ${./metadata.yml} \
      ${src}
  '';

in rec
{
  md.index = ./index.md;
  md.image = ./image.md;
  md.deploying = ./deploying.md;
  md.version = pkgs.writeText "version.md" ''
---
title: Versions
footer: © Võ Minh Thu, 2019. Version ${nix-notes-version}.
---


----------------------------------------------------------------  ------------------------
[design-system](https://github.com/hypered/design-system)         ${design-system-version}
[gitcraft](https://github.com/noteed/gitcraft)                    ${gitcraft-version}
[git-notes](https://github.com/noteed/git-notes)                  ${git-notes-version}
[nix-notes](https://github.com/noteed/nix-notes)                  ${nix-notes-version}
[noteed.com](https://github.com/noteed/noteed.com)                ${noteed-com-version}
----------------------------------------------------------------  ------------------------
  '';

  html.index = to-html md.index;
  html.image = to-html md.image;
  html.deploying = to-html md.deploying;
  html.version = to-html md.version;
  html.all = pkgs.runCommand "all" {} ''
    mkdir $out
    cp ${html.index} $out/index.html
    cp ${html.image} $out/image.html
    cp ${html.deploying} $out/deploying.html
    cp ${html.version} $out/version.html
    ${pkgs.bash}/bin/bash ${replace-md-links} $out
  '';

  inherit static;
}

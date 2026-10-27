{ nixpkgs ? (import ../nix/26.05/nix/sources.nix).nixpkgs
, nix-notes-version ? "not-given"
, gitcraft-version ? "not-given"
, git-notes-version ? "not-given"
, noteed-com-version ? "not-given"
}:

let
  sources = import ../nix/26.05/nix/sources.nix;
  pkgs = import nixpkgs {};

  design-system-version = sources.hypered-design.rev;
  inherit (import sources.hypered-design) template lua-filter replace-md-links static;

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
[design](https://github.com/hypered/design)                       ${design-system-version}
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

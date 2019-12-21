{ nixpkgs ? <nixpkgs>
, nix-notes-version ? "not-given"
, gitcraft-version ? "not-given"
, git-notes-version ? "not-given"
, noteed-github-com-version ? "not-given"
}:

let
  pkgs = import nixpkgs {};

  design-system-version = "e1fe8d82349f4a084dee751a9c4bc5ef81ee68bb";
  design-system = pkgs.fetchFromGitHub {
    owner = "hypered";
    repo = "design-system";
    rev = design-system-version;
    sha256 = "1lqsx2zq2ymib9x4b0xncgx4wjw1mkphr4zda84fj4lbx445rdii";
  };
  inherit (import design-system {}) to-html replace-md-links;

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
[noteed.github.com](https://github.com/noteed/noteed.github.com)  ${noteed-github-com-version}
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
}

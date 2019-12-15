---
title: Nix notes
footer: © Võ Minh Thu, 2019.
---


## Minimal examples

The file `example-0.nix`, called a derivation, has the following content:

```
let
  pkgs = import <nixpkgs> {};

in
  pkgs.runCommand "example-0" {} ''
    echo 'Built with Nix.' > $out
  ''
```

It is a script that, when built with Nix, creates a file with the content
`"Build with Nix."`.

```
$ nix build --file ./example-0.nix
[1 built, 0.0 MiB DL]
$ cat result
Built with Nix.
```

The file `result` is a symlink to the actual result, located in the Nix store:

```
$ readlink result
/nix/store/9f96vvg87vj6fn8ck37xz5annaiwmnp1-example-0
```


## Multiple results

Multiple results can be created by a single Nix script. Here is the content of
`example-1.nix`:

```
let
  pkgs = import <nixpkgs> {};

in
{
  example-0 = pkgs.runCommand "example-0" {} ''
    echo 'Built with Nix.' > $out
  '';
  example-1 = pkgs.runCommand "example-1" {} ''
    echo 'Built with Nix too.' > $out
  '';
}
```

When building that script, two results are created: `result` and `result-1`.
One can also choose to build a particular attribute:

```
$ nix build --file site/intro/example-1.nix example-1
```

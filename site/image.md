---
title: Nix notes
footer: © Võ Minh Thu, 2019.
---


## Start here: building a Digital Ocean image

```
$ nix-build -A image
@result@
```

This derivation builds a virtual machine image suitable for Digital Ocean: one
can import the resulting file as a custom image then select that image when
creating a new droplet (a droplet is the name DO gives to a virtual machine).
We'll do that in two commits (i.e. [here](deploying.md)).

As can be seen in `default.nix`, the Nix expression detailing our complete
image is quite simple: we call `<nixpkgs>/nixos/lib/eval-config.nix`, passing
two modules: one defined in nixpkgs containing the DO-specific bits, and
`./configuration.nix`.

Really, that's nixpkgs doing all the work!

Finally our `./configuration.nix` is a standard NixOS configuration file, just
like the one you would have in `/etc/nixos/configuration.nix`.

---
title: Nix notes
footer: © Võ Minh Thu, 2019.
---


## Toplevel: updating a running virtual machine

```
nix-build -A toplevel
@result@
```

In the blog post [Industrial-strength Deployments in Three
Commands](https://vaibhavsagar.com/blog/2019/08/22/industrial-strength-deployments/),
the toplevel is defined as

```
let
  nixos = import <nixpkgs/nixos> {
    configuration = import ./configuration.nix;
  };
in
  nixos.system
```

and is described as being the whole system. To be specific, the closure of
toplevel is a complete system and can be packaged as a rootfs, or in our case
as a qcow2 virtual machine [image](image.md). It also contains a script to
"activate" the system, for instance by copying files into `/etc/`.

To update a remote NixOS machine, the toplevel closure can be uploaded to it,
then activated there. See the above blog post for a description.

Say for instance that we update `site/index.html`, then we can update an
existing droplet with:

```
$ ./deploy.sh
```

instead of re-building a complete virtual machine image and provisioning a new
droplet.

TODO The droplet IP address is currently hard-coded in the `deploy.sh` script.

TODO Elaborate if I should copy the target `/etc/nixos/` configuration. I think
I check and that it only imports the user-data and the file from nixpkgs that I
already have.

TODO Check the links provided in the blog post for additional insights.

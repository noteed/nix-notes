---
title: Nix notes
footer: © Võ Minh Thu, 2019.
---


## Running the configuration inside a local VM

```
nix-build -A runvm
@result@
```

This derivation creates a script to launch a QEMU virtual machine using our
configuration, but sharing the Nix store with the host system. This is handy to
try the configuration before creating an image or uploading its toplevel to a
target machine.

Simply run the created script. You will be logged in automatically as root, and
can try for instance to get a page from Nginx.

```
$ result/bin/run-nixos-vm
...
# curl 127.0.0.1/git-notes/init.html
...
```

Type `Ctrl-a x` to exit QEMU.

---
title: Nix notes
footer: © Võ Minh Thu, 2019.
---


### A simple Servant-based HTTP backend service

```
nix-build -A app
@result@
```

It is possible to evaluate our configuration to see the generated Systemd unit
file:

```
$ nix-instantiate --eval -A 'os.config.systemd.units."app.service".text' | jq -r
```

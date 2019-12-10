---
title: Nix notes
footer: © Võ Minh Thu, 2019.
---


### Using cron to run scheduled jobs

```
nix-build -A crontab
@result@
```

The above command builds the file that will end up at `/etc/crontab` within the
virtual machine.

Note: the ability to describe files in the `/etc` hierarchy is a special
feature of NixOS; it hasn't support to create arbitrary files elsewhere.

It is possible to evaluate our configuration to see the generated Systemd unit
file:

```
$ nix-instantiate --eval -A 'os.config.systemd.units."cron.service".text' | jq -r
```

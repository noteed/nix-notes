---
title: Nix notes
footer: © Võ Minh Thu, 2019.
---


## Sending emails with ssmtp

To allow the virtual machine to send emails, we enable `services.ssmtp` in the
`configuration.nix`, and fill in some additional details.

The most interesting one is `authPassFile = "/run/keys/ssmtp-authpass"`. It
contains the path to a file containing the password to use an SMTP server. That
file should not be versioned (as can be see in `.gitignore`) and should not be
in the Nix store. The `deploy.sh` script is adapted to copy secrets outside the
Nix store before activating the new configuration.

Testing if emails can ben sent can be done by SSHing into the remote host (or
using the `runvm.sh` script) with the following command:

```
echo -e -n "To: Thu\nFrom: noteed.com\nSubject: Test\n\nTesting ssmtp" \
  | sendmail -v noteed@gmail.com
```

Note: if you don't include a "From" field, the one used is from `/etc/passwd`,
which is "System administrator" for the root user.

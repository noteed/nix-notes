---
title: Nix notes
footer: © Võ Minh Thu, 2019.
---


## Aside: environment variables used for credentials

As can be seen in the `.gitignore` file, I'm using two files that are not versioned:
`.envrc` and `s3-config`.

The `.envrc` file is used by an utility called `direnv` and contains
environment variable definitions. In particular for this project, it contains
credentials for both an S3 API, and the Digital Ocean API. Those values are
used by `doctl` and `s3cmd`.

Although I'm using Digital Ocean Spaces instead of Amazon S3, the environment
variables are still named `AWS_*`.

Upon entering a directory with an `.envrc` file, `direnv` will load the
environment variables it defines:

```
$ cd nix-notes
/home/thu/projects/nix-notes
direnv: loading .envrc
direnv: export +AWS_ACCESS_KEY_ID +AWS_SECRET_ACCESS_KEY +DIGITALOCEAN_ACCESS_TOKEN
```

In addition to the credentials, the `s3-config` file is used to configure
`s3cmd` to point to Spaces instead of defaulting to Amazon. That part of the
file is not sensitive but it may happen that credentials get written to it.

```
$ grep host_b s3-config 
host_base = ams3.digitaloceanspaces.com
host_bucket = %(bucket)s.ams3.digitaloceanspaces.com
```

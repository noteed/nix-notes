# Nix notes

This is a collection of short notes about Nix and NixOS. Almost each note
corresponds to a page, to a Git commit, and to a Nix attribute that can be
built.

The result is a virtual machine image that actually runs as
[noteed.com](https://noteed.com).


## How to read these notes

The notes should be read with a copy of this repository. To make each note
correspond to a commit, this repository is heavily rebased. When studying a
particular note, especially the first ones, it is best to checkout the
corresponding commit to see only the relevant files for that note.

In other words, running `git log --patch --reverse` should be a readable
tutorial about Nix and NixOS. Indeed, the following table of content is
generated with `git log --reverse`!


## Bleeding edge

Note: building Digital Ocean images is a recent addition to nixpkgs, and
uploading a custom image is a recent feature of `doctl`. Assuming `../nixpkgs`
is a recent checkout (around 2019-12-13), I'm using a Nix shell like this:

```
$ NIX_PATH=nixpkgs=../nixpkgs nix-shell -p doctl
```


## Table of content


### Start here: building a Digital Ocean image

In this commit, we introduce a short Nix expression to build a virtual machine
image that can be run on Digital Ocean. The expression is short because all the
machinery to do the heavy lifting is in nixpkgs. [More.](site/image.md)


### Aside: environment variables used for credentials

In this commit, we talk about two files that are in fact non under version-control.
They are used to store credentials for two command-line tools: `s3cmd` and `doctl`.
[More.](site/credentials.md)


### Deploying the image to Digital Ocean

In this commit, we add two scripts using the `s3cmd` and `doctl` tools. They
use the credentials introduced in the previous commit: `s3cmd` uploads to S3
the image built in the commit before, and `doctl` is used to import the image
into Digital Ocean then spin a new virtual machine. [More.](site/deploying.md)


### Adding a static site to the Nginx configuration

In this commit, we add a simple static site to our image. In the next commit,
we'll see how to update an existing virtual machine with this static site,
without rebuilding an image or a droplet. [More.](site/site.md)


### Toplevel: updating a running virtual machine

In this commit, we add a new `toplevel` attribute, and a `deploy.sh` script.
The toplevel corresponds to the content of a virtual machine (before it is
packaged as such), and the `deploy.sh` script syncs an existing NixOS machine
so that it matches the new toplevel. [More.](site/toplevel.md)


## Details

The `configuration.nix` file is taken from the
[nixos-generators](https://github.com/nix-community/nixos-generators) project,
which makes it easy to build images in various formats, including the one used
here.

I use the same Digital Ocean facility for both S3 and the droplets (i.e. ams3).

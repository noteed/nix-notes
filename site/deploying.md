---
title: Nix notes
footer: © Võ Minh Thu, 2019.
---


## Deploying the image to Digital Ocean

The first step is to build a NixOS [image](image.md) in the qcow2 format:

```
$ ./build-image.sh
```

The second step is to upload the image somewhere where Digital Ocean can later
import it using HTTP. Here we upload the image to S3:

```
$ ./upload-image.sh
```

The third step is to import the image into Digital Ocean, so we can refer to it
when creating a new droplet:

```
$ ./import-image.sh
```

Finally, the fourth step is create a new droplet, specifying the custom image:

```
$ ./create-droplet.sh
```

TODO The image ID is currently hard-coded in the `create-droplet.sh` script.

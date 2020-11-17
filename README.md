# GCloud, Kubectl, Helm - minimized & multi-arch

Yes. **Minimized** & **Multi-Arch** - based on Alpine Linux! Serves your basic CI/CD needs.

## Features:
* **Multi-Arch** - `linux/386,linux/amd64,linux/arm/v7,linux/arm64,linux/ppc64le,linux/s390x`
* **docker** - latest - `19.03`
* **docker-credential-gcloud** 
* **gcloud** - latest - `316.*.*`
* **gsutil** - latest - `4.54`
* **git-credential-gcloud**
* **kubectl** - only *one* binary with latest version - `1.15`
* **helm** - latest - `v3.*.*`
* Standard unix tools normally included in Alpine OS - `3.12`


## How small is this image?
```
[kamran@kworkhorse ~]$ docker images | grep 'gcp-tools'
praqma/gcp-tools                       latest                     9e8a15b1c846        17 seconds ago      546MB
[kamran@kworkhorse ~]$ 
```

This is about five times smaller than `google/cloud-sdk` which is `2.4 GB` in size!

**Note:** I could have taken out the `docker` binary too, reducing the image further by about `60 MB`, but I left it in there.

*Enjoy!*

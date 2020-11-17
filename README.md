# Google Cloud SDK - minimized - multi-arch

Yes. Minimized & Multi-Arch - using Alpine! - for your basic CI/CD needs.

## The pain:
```
[kamran@kworkhorse ~]$ docker images | grep 'google/cloud-sdk'
google/cloud-sdk                       latest                     00307be05fcd        2 weeks ago         2.41GB
[kamran@kworkhorse ~]$ 
```

**2.4 GB! Just for gcloud and kubectl?** 

We could definitely do better.

## The solution:
```
[kamran@kworkhorse ~]$ docker images | grep 'praqma/gcp-tools'
praqma/gcp-tools                       latest                     349531cde907        16 seconds ago      484MB
[kamran@kworkhorse ~]$ 
```

This is at least five times smaller than the painful one!

## Features:
* Multi-Arch - linux/386,linux/amd64,linux/arm/v7,linux/arm64,linux/ppc64le,linux/s390x
* gcloud - latest - `316.*.*`
* kubectl - only *one* binary with latest version - `1.15`
* helm - latest - `v3.*.*`
* Standard unix tools normally included in Alpine OS - `3.12`

Most people use `docker` in an independent CI job - using Docker's official container image, so `docker` is not part of this image. 

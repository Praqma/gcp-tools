# Google Cloud SDK - minimized - multi-arch

More and more people are moving their setup to various cloud providers, and have started to use CI/CD to build/test/.../deploy their applications. Most of the time the target deployment platform is Kubernetes. Naturally your CI/CD job needs to talk to various components of these systems. 

## The pain:
```
[kamran@kworkhorse ~]$ docker images | grep 'google/cloud-sdk'
google/cloud-sdk                       latest                     00307be05fcd        2 weeks ago         2.41GB
[kamran@kworkhorse ~]$ 
```

As you can see, the above image is **2.4 GB!** . Most of the time we are only using `gcloud` and `kubectl` out of this humongous image. Downloading `2.4 GB` may not mean much to some, but it does mean a lot to others. I am running a `gitlab-runner` on my home server, and downloading a **"2.4 GB"** image for every job is a huge strain on my internet link. 

So, I thought, I could do better.

The container image shown above is not Alpine based. So, I started with Alpine version of Google's SDK, which starts with `553 MB`. The alpine version of this SDK does not include the tools used by ordinary people like me. So I thought I will simply add `kubectl` (and `helm`) in this image and will call it a day. Unfortunately adding `kubectl` and `helm` to this image expands it's size to `1.7 GB`! Have a look yourself:

```
[kamran@kworkhorse gcloud-alpine]$ docker images | grep 'local/google-cloud-sdk'
local/google-cloud-sdk                 alpine                     b6bcfee1f959        2 weeks ago         1.74GB
[kamran@kworkhorse gcloud-alpine]$
```

So from `2.4 GB` down to `1.7 GB`. Still not a huge gain. I needed to do even better. 

## The solution:
I redesigned my solution. This time, I took Alpine version of Google's SDK, and in it, I installed the stuff I needed, removed the stuff which I did not need, created a multi-stage build and only copied the stuff I needed from the previous layer to the final layer of the container image, and threw away everything else. 

The result was very satisfying. Have a look yourself:

```
[kamran@kworkhorse ~]$ docker images | grep 'praqma/gcp-tools'
praqma/gcp-tools                       latest                     349531cde907        16 seconds ago      484MB
[kamran@kworkhorse ~]$ 
```

This is at least five times smaller than the painful one! Finally! Hurray!

## Features:
* **Multi-Arch** - linux/386,linux/amd64,linux/arm/v7,linux/arm64,linux/ppc64le,linux/s390x
* **gcloud** - latest - `316.*.*`
* **kubectl** - only *one* binary with latest version - `1.15`
* **helm** - latest - `v3.*.*`
* Standard unix tools normally included in Alpine OS - `3.12`

**Note:** Most people use `docker` in an independent CI job - using Docker's official container image, so `docker` is not part of this image. 

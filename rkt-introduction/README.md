# rkt Containers

rkt (pronounced "rock-it") is a CLI for running application containers on Linux, designed to be secure, composable, and standards-based.

* Pod-native: rkt's basic unit of execution is a pod.
* Security: rkt is developed with a principle of "secure-by-default".
* Composability: rkt is designed for first-class integration with init systems (like systemd) and cluster orchestration tools (k8s, nomad).
* Open standards and compatibility: rkt implements the appc specification, supports the CNI spec, and can run Docker Images and OCI images.

> https://github.com/rkt/rkt/

# History

CoreOS started building rkt because they felt that Docker was no longer “the simple composable building block had envisioned.”

> December 01, 2014
https://coreos.com/blog/rocket.html

# Install rkt

rkt is an integral part of Container Linux, installed with the operating system.

Installing rkt on popular Linux distributions :

https://coreos.com/rkt/docs/latest/distributions.html

# rkt vs Docker

Docker process model: basically everything runs through a central daemon

https://coreos.com/rkt/docs/latest/rkt-vs-other-projects.html#rkt-vs-docker

> Tips

https://medium.com/@adriaandejonge/moving-from-docker-to-rkt-310dc9aec938

## rkt CLI vs Docker CLI

A CLI for running app containers on Linux.

```sh
sudo rkt help
```
>  fetch, run, list, enter, image, stop, rm, gc

| Docker                       | rkt       |
|------------------------------|-----------|
| docker pull                  | rkt fetch |
| docker run                   | rkt run   |
| docker ps                    | rkt list  |
| docker exec                  | rkt enter |
| docker image                 | rkt image |
| docker stop                  | rkt stop  |
| docker rm                    | rkt rm    |
| docker rm $(docker ps -a -q) | rkt gc    |

# Running Docker images with rkt

```sh
rkt run --insecure-options=image --net=host docker://nginx
```

# Running ACI images with rkt

```sh
rkt run --interactive=true rkt.devopsfloripa.io/alpine:3.6
```

```sh
rkt run --interactive=true rkt.devopsfloripa.io/alpine:3.6 --seccomp mode=remove,errno=ENOTSUP,network-io
```

# Building an App Container Image

* rkt's native image format is the [App Container Image (ACI)][3], defined in the App Container spec.
* The [acbuild tool][4] is a simple way to get started building ACIs.

> Tips

* https://github.com/blablacar/dgr

# Docker registry Vs ACI discovery

https://github.com/appc/spec/blob/master/spec/discovery.md

> Tips

* [rkt-registry][1] with AWS S3/CloudFront
* [aci-discovery][2]

---

[1]:https://github.com/Luzifer/rkt-registry
[2]:https://github.com/coreos/aci-discovery
[3]:https://github.com/rkt/rkt/blob/master/Documentation/app-container.md
[4]:https://github.com/containers/build

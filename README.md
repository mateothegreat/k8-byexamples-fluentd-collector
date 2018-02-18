<!--
#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
#-->

[![Clickity click](https://img.shields.io/badge/k8s%20by%20example%20yo-limit%20time-ff69b4.svg?style=flat-square)](https://k8.matthewdavis.io)
[![Twitter Follow](https://img.shields.io/twitter/follow/yomateod.svg?label=Follow&style=flat-square)](https://twitter.com/yomateod) [![Skype Contact](https://img.shields.io/badge/skype%20id-appsoa-blue.svg?style=flat-square)](skype:appsoa?chat)

# Fluentd Log Collection & Transport (via DaemonSet)
## Usage

```sh
$ make help

                                __                 __
   __  ______  ____ ___  ____ _/ /____  ____  ____/ /
  / / / / __ \/ __  __ \/ __  / __/ _ \/ __ \/ __  /
 / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
 \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
/____
                        yomateo.io, it ain't easy.

Usage: make <target(s)>

Targets:

  git/update           Update submodule(s) to HEAD from origin
  install              Installs manifests to kubernetes using kubectl apply (make manifests to see what will be installed)
  delete               Deletes manifests to kubernetes using kubectl delete (make manifests to see what will be installed)
  get                  Retrieves manifests to kubernetes using kubectl get (make manifests to see what will be installed)
  describe             Describes manifests to kubernetes using kubectl describe (make manifests to see what will be installed)
  context              Globally set the current-context (default namespace)
  shell                Grab a shell in a running container
  dump/logs            Find first pod and follow log output
  dump/manifests       Output manifests detected (used with make install, delete, get, describe, etc)

  ```

## Install

```sh

$ make install
[ INSTALLING MANIFESTS/DAEMONSET.YAML ]: daemonset "fluentd" created[ INSTALLING MANIFESTS/FLUENTD-CONFIG-CONFIGMAP.YAML ]: configmap "fluentd-configmap" created
[ INSTALLING MANIFESTS/RBAC-CLUSTER-ROLE-BINDING.YAML ]: clusterrolebinding "fluentd-service-account" created
[ INSTALLING MANIFESTS/RBAC-CLUSTER-ROLE.YAML ]: clusterrole "fluentd-service-account" created[ INSTALLING MANIFESTS/RBAC-SERVICE-ACCOUNT.YAML ]: serviceaccount "fluentd-service-account" created

```

## Viewing Logs

```sh
$ make dump/logs

2018-02-18 05:58:01 +0000 [info]: #0 following tail of /var/log/containers/cert-manager-6c979cb867-m5d25_default_ingress-shim-88f18629bc16cf3c16c7dee989439718115bd6b808404e4bd1b94245d0195e71.log
2018-02-18 05:58:01 +0000 [info]: #0 following tail of /var/log/containers/kube-dns-6cdf767cb8-wktsj_kube-system_dnsmasq-377ba729f470687f43c882665425a15f1e409a9d9c469a54fdee040a24bda161.log
2018-02-18 05:58:01 +0000 [info]: #0 following tail of /var/log/containers/kube-proxy-gke-cluster-4-default-pool-678a19f9-smqf_kube-system_kube-proxy-7b4cdde5a8c14f467e9c2d7c8d3431016b0e724b00c99c3d0bc4703812101206.log
2018-02-18 05:58:01 +0000 [info]: #0 following tail of /var/log/containers/fluentd-9xjg6_kube-system_fluentd-a901ecdaacac09467d4922a58271d235d4aceed0f7960c31690a2245ff06e51a.log
2018-02-18 05:58:01 +0000 [info]: #0 fluentd worker is now running worker=0
2018-02-18 05:58:07 +0000 [info]: #0 Connection opened to Elasticsearch cluster => {:host=>"elasticsearch.default.svc.cluster.local", :port=>9200, :scheme=>"http", :user=>"elastic", :password=>"obfuscated"}
2018-02-18 05:58:37 +0000 [info]: #0 stats - namespace_cache_size: 2, pod_cache_size: 3, namespace_cache_api_updates: 3, pod_cache_api_updates: 3, id_cache_miss: 3

```

## Cleanup

```sh

 make delete
[ DELETING MANIFESTS/DAEMONSET.YAML ]: daemonset "fluentd" deleted
[ DELETING MANIFESTS/FLUENTD-CONFIG-CONFIGMAP.YAML ]: configmap "fluentd-configmap" deleted
[ DELETING MANIFESTS/RBAC-CLUSTER-ROLE-BINDING.YAML ]: clusterrolebinding "fluentd-service-account" deleted
[ DELETING MANIFESTS/RBAC-CLUSTER-ROLE.YAML ]: clusterrole "fluentd-service-account" deleted[ DELETING MANIFESTS/RBAC-SERVICE-ACCOUNT.YAML ]: serviceaccount "fluentd-service-account" deleted
```
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

> k8 by example -- straight to the point, simple execution.

* RBAC: ServiceAccount
* RBAC: ClusterRole
* RBAC: ClusterRoleBinding
* DaemonSet

## Environment Variables

```
NS                          ?= kube-system
SERVICE_ACCOUNT             ?= fluentd-service-account
FLUENT_ELASTICSEARCH_HOST   ?= elasticsearch
FLUENT_ELASTICSEARCH_PORT   ?= 9200
```

## All Targets

You can invoke individual targets with `make <target name(s)>`.
I.e.: `make service-account-install service-account-get`.

```
install:    service-account-install cluster-role-install cluster-role-binding-install daemonset-install
delete:     cluster-role-binding-delete cluster-role-delete service-account-delete daemonset-delete
get:        service-account-get cluster-role-get cluster-role-binding-get configmap-get daemonset-get
```

## Install all (RBAC + DaemonSet)

```sh
yomateod@proliant:/workspace/k8/k8-byexamples-fluentd-collector$ make install

serviceaccount "fluentd-service-account" created

clusterrole "fluentd-service-account" created
clusterrolebinding "fluentd-service-account" created

daemonset "fluentd" created
```

## Delete all (RBAC + DaemonSet)

```sh
yomateod@proliant:/workspace/k8/k8-byexamples-fluentd-collector$ make delete

clusterrolebinding "fluentd-service-account" deleted
clusterrole "fluentd-service-account" deleted

serviceaccount "fluentd-service-account" deleted

daemonset "fluentd" deleted
```

[![Analytics](https://ga-beacon.appspot.com/UA-113335243-2/welcome-page)](https://github.com/mateothegreat/k8-byexamples-fluentd-collector)

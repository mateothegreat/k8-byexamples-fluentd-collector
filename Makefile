#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
include .make/Makefile.inc

NS                      ?= kube-system
APP						?= fluentd-logging
SERVICE_ACCOUNT         ?= fluentd-service-account
ELASTICSEARCH_HOST      ?= elasticsearch.default.svc.cluster.local
ELASTICSEARCH_PORT      ?= 9200
ELASTICSEARCH_SCHEME    ?= http
FLUENT_LOG_LEVEL        ?= info
# Only used when X-Pack Authentication is enabled
ELASTICSEARCH_USER      ?= elastic
ELASTICSEARCH_PASSWORD  ?= changeme
export

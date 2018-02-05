#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#

NS                      ?= kube-system
SERVICE_ACCOUNT         ?= fluentd-service-account
ELASTICSEARCH_HOST      ?= elasticsearch.es.svc.cluster.local
ELASTICSEARCH_PORT      ?= 9200
ELASTICSEARCH_SCHEME    ?= http
FLUENT_LOG_LEVEL        ?= info
# Only used when X-Pack Authentication is enabled
ELASTICSEARCH_USER      ?= elastic
ELASTICSEARCH_PASSWORD  ?= changeme

export

install:    service-account-install cluster-role-install cluster-role-binding-install daemonset-install
delete:     cluster-role-binding-delete cluster-role-delete service-account-delete daemonset-delete
get:        service-account-get cluster-role-get cluster-role-binding-get configmap-get daemonset-get


#
# DaemonSet
#
daemonset-install:

	@envsubst < daemonset.yaml | kubectl --namespace $(NS) apply -f -

daemonset-delete:

	@envsubst < daemonset.yaml | kubectl --namespace $(NS) delete -f -

daemonset-get:

	kubectl --namespace $(NS) get daemonset

#
# ConfigMap
#
configmap-install:

	@envsubst < fluentd-config-configmap.yaml | kubectl --namespace $(NS) apply -f -

configmap-delete:

	@envsubst < fluentd-config-configmap.yaml | kubectl --namespace $(NS) delete -f -

configmap-get:

	kubectl --namespace $(NS) get configmap

#
# Service Account
#
service-account-install:

	@envsubst < service-account.yaml | kubectl --namespace $(NS) apply -f -

service-account-delete:

	@envsubst < service-account.yaml | kubectl --namespace $(NS) delete -f -

service-account-get:

	kubectl --namespace $(NS) get sa

#
# Cluster Role
#
cluster-role-install:

	@envsubst < cluster-role.yaml | kubectl --namespace $(NS) apply -f -

cluster-role-delete:

	@envsubst < cluster-role.yaml | kubectl --namespace $(NS) delete -f -

cluster-role-get:

	kubectl --namespace $(NS) get clusterrole

#
# Cluster Role Binding
#
cluster-role-binding-install:

	@envsubst < cluster-role-binding.yaml | kubectl --namespace $(NS) apply -f -

cluster-role-binding-delete:

	@envsubst < cluster-role-binding.yaml | kubectl --namespace $(NS) delete -f -

cluster-role-binding-get:

	kubectl --namespace $(NS) get clusterrolebinding


## Find first pod and follow log output
logs:

	@$(eval POD:=$(shell kubectl get pods --all-namespaces -lk8s-app=fluentd-logging -o jsonpath='{.items[0].metadata.name}'))
	echo $(POD)

	kubectl --namespace $(NS) logs -f $(POD)

# Help Outputs
GREEN  		:= $(shell tput -Txterm setaf 2)
YELLOW 		:= $(shell tput -Txterm setaf 3)
WHITE  		:= $(shell tput -Txterm setaf 7)
RESET  		:= $(shell tput -Txterm sgr0)
help:

	@echo "Deploy & Manage Kibana in Kubernetes."
	@echo "\nUsage:\n\n  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}\n\nTargets:\n"
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-20s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

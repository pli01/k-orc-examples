SHELL := /bin/bash
HELM_VALUE := env/test-local/values.yaml
HELM_NAMESPACE := orc-test
HELM_RELEASE_NAME := orc-test

all:
	echo Please read doc

deploy: network-install instance-install
install: network-install instance-install
upgrade: network-upgrade instance-upgrade
uninstall: instance-uninstall network-uninstall
template: instance-template network-template

network-install:
	helm status  -n $(HELM_NAMESPACE) $(HELM_RELEASE_NAME) || \
	  helm install -n $(HELM_NAMESPACE) -f $(HELM_VALUE) $(HELM_RELEASE_NAME) usecases/charts/routed-network
network-upgrade:
	helm status  -n $(HELM_NAMESPACE) $(HELM_RELEASE_NAME) && \
	  helm upgrade -n $(HELM_NAMESPACE) -f $(HELM_VALUE) $(HELM_RELEASE_NAME) usecases/charts/routed-network
network-uninstall:
	helm status  -n $(HELM_NAMESPACE) $(HELM_RELEASE_NAME) && \
	  helm uninstall -n $(HELM_NAMESPACE) $(HELM_RELEASE_NAME)
network-template:
	helm template -n $(HELM_NAMESPACE) -f $(HELM_VALUE) $(HELM_RELEASE_NAME) usecases/charts/routed-network

instance-install:
	helm status  -n $(HELM_NAMESPACE) $(HELM_RELEASE_NAME)-instance || \
	  helm install -n $(HELM_NAMESPACE) -f $(HELM_VALUE) $(HELM_RELEASE_NAME)-instance usecases/charts/instance
instance-upgrade:
	helm status  -n $(HELM_NAMESPACE) $(HELM_RELEASE_NAME)-instance && \
	  helm upgrade -n $(HELM_NAMESPACE) -f $(HELM_VALUE) $(HELM_RELEASE_NAME)-instance usecases/charts/instance
instance-uninstall:
	helm status  -n $(HELM_NAMESPACE) $(HELM_RELEASE_NAME)-instance && \
	  helm uninstall -n $(HELM_NAMESPACE) $(HELM_RELEASE_NAME)-instance

instance-template:
	helm template -n $(HELM_NAMESPACE) -f $(HELM_VALUE) $(HELM_RELEASE_NAME)-instance usecases/charts/instance

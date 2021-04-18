DOP_CLIENT_REACT_DEPLOYMENT := dop-client-react-deployment
DOP_SERVER_FLASK_DEPLOYMENT := dop-server-flask-deployment
DOP_MICROSERVICE_DEPLOYMENT := dop-microservice-deployment
DOP_KAFKA_CONSUMER_DEPLOYMENT := dop-kafka-consumer-deployment
HELM_ROOT:=helm/deployment
RELEASE_NAME:=first-release

.DEFAULT_GOAL := deploy_dev # set default target to run

# ======= Deployment =======
deploy_dev:
	helm upgrade --install $(RELEASE_NAME) -f $(HELM_ROOT)/local_values.yaml $(HELM_ROOT)

delete_all:
	helm delete $(RELEASE_NAME)

history:
	helm history $(RELEASE_NAME)

# ======= Development =======
get_ips: # go to this IP on the browser
	minikube service --url dop-client-react-service
	minikube service --url dop-server-flask-service

status:
	kubectl get pods

debug: # Note that you might need to wait for the container to be deployed before you can actually run the shell. You can try curl dop-server-flask-service:8000/api/ once you are in the shell
	kubectl apply -f helpers/debug-container.yml
	kubectl exec -it curlcontainer -- sh 

shell_dop_client_react:
	@$(eval podname = $(shell kubectl get pods | grep -o '$(DOP_CLIENT_REACT_DEPLOYMENT)-[a-z0-9\-]*'))
	kubectl exec --stdin --tty $(podname) -- /bin/sh

logs_dop_client_react:
	@$(eval podname = $(shell kubectl get pods | grep -o '$(DOP_CLIENT_REACT_DEPLOYMENT)-[a-z0-9\-]*'))
	kubectl logs --follow $(podname)

shell_dop_server_flask:
	@$(eval podname = $(shell kubectl get pods | grep -o '$(DOP_SERVER_FLASK_DEPLOYMENT)-[a-z0-9\-]*'))
	kubectl exec --stdin --tty $(podname) -- /bin/sh

logs_dop_server_flask:
	@$(eval podname = $(shell kubectl get pods | grep -o '$(DOP_SERVER_FLASK_DEPLOYMENT)-[a-z0-9\-]*'))
	kubectl logs --follow $(podname)

shell_dop_kafka_consumer:
	@$(eval podname = $(shell kubectl get pods | grep -o '$(DOP_KAFKA_CONSUMER_DEPLOYMENT)-[a-z0-9\-]*'))
	kubectl exec --stdin --tty $(podname) -- /bin/sh

shell_dop_microservice:
	@$(eval podname = $(shell kubectl get pods | grep -o '$(DOP_MICROSERVICE_DEPLOYMENT)-[a-z0-9\-]*'))
	kubectl exec --stdin --tty $(podname) -- /bin/sh

shell_broker:
	@$(eval podname = $(shell kubectl get pods | grep -o 'kafka-broker[a-z0-9\-]*'))
	kubectl exec --stdin --tty $(podname) -- /bin/sh

logs_broker:
	@$(eval podname = $(shell kubectl get pods | grep -o 'kafka-broker[a-z0-9\-]*'))
	kubectl logs --follow $(podname)

healthcheck:
	curl http://localhost:30002/api/

list:
	@echo make deploy_dev
	@echo make delete_all
	@echo make history
	@echo make get_ips
	@echo make status
	@echo make debug
	@echo make shell_dop_client_react
	@echo make logs_dop_client_react
	@echo make shell_dop_server_flask
	@echo make logs_dop_server_flask
	@echo make shell_dop_kafka_consumer
	@echo make shell_dop_microservice
	@echo make shell_broker
	@echo make logs_broker
	@echo make healthcheck

DOP_CLIENT_REACT_DEPLOYMENT := dop-client-react-deployment
DOP_SERVER_FLASK_DEPLOYMENT := dop-server-flask-deployment
DOP_MICROSERVICE_DEPLOYMENT := dop-microservice-deployment
HELM_ROOT:=helm/deployment/

# ======= Deployment =======
deploy_dev:
	helm upgrade first-release -f $(HELM_ROOT)local_values.yaml $(HELM_ROOT)

deploy_prod:
	helm upgrade first-release -f $(HELM_ROOT)prod_values.yaml $(HELM_ROOT)

delete_all:
	kubectl delete --all deployments
	kubectl delete --all services

# ======= Development =======
debug: # Note that you might need to wait for the container to be deployed before you can actually run the shell
	kubectl apply -f helpers/debug-container.yml
	# you can try curl dop-server-flask-service:8000/api/ once you are in the shell
	kubectl exec -it curlcontainer -- sh 

shell_dop_client_react:
	@$(eval podname = $(shell kubectl get pods | grep -o '$(DOP_CLIENT_REACT_DEPLOYMENT)-[a-z0-9\-]*'))
	kubectl exec --stdin --tty $(podname) -- /bin/sh

shell_dop_server_flask:
	@$(eval podname = $(shell kubectl get pods | grep -o '$(DOP_SERVER_FLASK_DEPLOYMENT)-[a-z0-9\-]*'))
	kubectl exec --stdin --tty $(podname) -- /bin/sh

shell_dop_microservice:
	@$(eval podname = $(shell kubectl get pods | grep -o '$(DOP_MICROSERVICE_DEPLOYMENT)-[a-z0-9\-]*'))
	kubectl exec --stdin --tty $(podname) -- /bin/sh

shell_broker:
	@$(eval podname = $(shell kubectl get pods | grep -o 'kafka-[a-z0-9\-]*'))
	kubectl exec --stdin --tty $(podname) -- /bin/sh

healthcheck:
	curl http://localhost:30002/api/

DOP_CLIENT_REACT_DEPLOYMENT := dop-client-react-deployment
DOP_SERVER_FLASK_DEPLOYMENT := dop-server-flask-deployment
DOP_MICROSERVICE_DEPLOYMENT := dop-microservice-deployment

.DEFAULT_GOAL := deploy # set default target to run

# ====== Kubernetes Deployment ======
deploy:
	make deploy_dop_client_react
	make deploy_dop_server_flask
	make deploy_dop_microservice

deploy_dop_client_react:
	kubectl apply -f dop_client_react/deployment.yml -f dop_client_react/service.yml

deploy_dop_server_flask:
	kubectl apply -f dop_server_flask/deployment.yml -f dop_server_flask/service.yml

deploy_dop_microservice:
	kubectl apply -f dop_microservice/deployment.yml -f dop_microservice/service.yml

# To repull the Docker image from Docker Hub, we need to use kubectl rollout restart
redeploy:
	make redeploy_dop_client_react
	make redeploy_dop_server_flask
	make redeploy_dop_microservice

redeploy_dop_client_react:
	kubectl rollout restart deployment $(DOP_CLIENT_REACT_DEPLOYMENT)

redeploy_dop_server_flask:
	kubectl rollout restart deployment $(DOP_SERVER_FLASK_DEPLOYMENT)

redeploy_dop_microservice:
	kubectl rollout restart deployment $(DOP_MICROSERVICE_DEPLOYMENT)

delete_all:
	kubectl delete --all deployments
	kubectl delete --all services

# ======= Development =======
debug: # Note that you might need to wait for the container to be deployed before you can actually run the shell
	kubectl apply -f helpers/debug-container.yml
	kubectl exec -it curlcontainer -- sh 
	# you can try curl dop-server-flask-service:8000/api/ once you are in the shell

shell_dop_client_react:
	@$(eval podname := $(shell kubectl get pods | grep -o '$(DOP_CLIENT_REACT_DEPLOYMENT)-[a-z0-9\-]*'))
	kubectl exec --stdin --tty $(podname) -- /bin/sh

shell_dop_server_flask:
	@$(eval podname := $(shell kubectl get pods | grep -o '$(DOP_SERVER_FLASK_DEPLOYMENT)-[a-z0-9\-]*'))
	kubectl exec --stdin --tty $(podname) -- /bin/sh

shell_dop_microservice:
	@$(eval podname := $(shell kubectl get pods | grep -o '$(DOP_MICROSERVICE_DEPLOYMENT)-[a-z0-9\-]*'))
	kubectl exec --stdin --tty $(podname) -- /bin/sh

healthcheck:
	curl http://localhost:30002/api/

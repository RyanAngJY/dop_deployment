# ====== Kubernetes Deployment ======
deploy-frontend:
	kubectl apply -f dop_client_react/deployment.yml -f dop_client_react/service.yml

deploy_dop_server_flask:
	kubectl apply -f dop_server_flask/deployment.yml -f dop_server_flask/service.yml

deploy_dop_microservice:
	kubectl apply -f dop_microservice/deployment.yml -f dop_microservice/service.yml

deploy:
	make deploy-frontend
	make deploy_dop_server_flask
	make deploy_dop_microservice

delete_all:
	kubectl delete --all deployments
	kubectl delete --all services

# ======= Development =======
debug: # Note that you might need to wait for the container to be deployed before you can actually run the shell
	kubectl apply -f helpers/debug-container.yml
	kubectl exec -it curlcontainer -- sh 

shell:
	# note that you need to run `kubectl get pods` to get the pod name
	kubectl exec --stdin --tty dop-server-flask-deployment-556bc4b865-nsvpr -- /bin/sh

healthcheck:
	curl http://localhost:30002/api/

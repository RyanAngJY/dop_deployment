deploy-frontend:
	kubectl apply -f frontend/deployment-frontend.yml -f frontend/service-frontend.yml

deploy-backend:
	kubectl apply -f backend/deployment-backend.yml -f backend/service-backend.yml

deploy-dop-microservice:
	kubectl apply -f dop_microservice/deployment-dop-microservice.yml -f dop_microservice/service-dop-microservice.yml

deploy:
	make deploy-frontend
	make deploy-backend
	make deploy-dop-microservice

debug: # Note that you might need to wait for the container to be deployed before you can actually run the shell
	kubectl apply -f helpers/debug-container.yml
	kubectl exec -it curlcontainer -- sh 

delete_all:
	kubectl delete --all deployments
	kubectl delete --all services

shell:
	# note that you need to run `kubectl get pods` to get the pod name
	kubectl exec --stdin --tty deployment-flask-backend-556bc4b865-nsvpr -- /bin/sh

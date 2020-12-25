deploy-frontend:
	kubectl apply -f frontend/deployment-frontend.yml -f frontend/service-frontend.yml

deploy-backend:
	kubectl apply -f backend/deployment-backend.yml -f backend/service-backend.yml

deploy:
	make deploy-frontend
	make deploy-backend

debug: # Note that you might need to wait for the container to be deployed before you can actually run the shell
	kubectl apply -f helpers/debug-container.yml
	kubectl exec -it curlcontainer -- sh 

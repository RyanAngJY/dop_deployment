# To Deploy

```
cd ../dop_client_react
make push

cd ../dop_server_flask
make push

cd ../dop_microservice
make push

cd ../dop_deployment
make deploy_dev
```

Then, open the browser at http://192.168.64.2:30001 (if using Minikube)
OR
Then, open the browser at http://localhost:30001 (if using Docker Desktop's Kubernetes)

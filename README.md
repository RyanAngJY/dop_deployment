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

Run `minikube service dop-client-react-service --url`. Then, open the browser at the giver URL (if using Minikube)
OR
Then, open the browser at http://localhost:30001 (if using Docker Desktop's Kubernetes)

## To test connectivity within the Cluster itself
For Backend Server:
```
apk add curl
curl http://dop-server-flask-service:8000/api/
curl http://<Cluster IP>:8000/api/
```

For Microservice:
```
apk add busybox-extras
telnet dop-microservice-service 50051
```
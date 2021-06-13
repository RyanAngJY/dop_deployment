# To Oon AWS EKS Cluster Deploy
- Use the "load-balancer.yaml" instead of "service.yaml"
```
k config use-context arn:aws:eks:ap-southeast-1:504067213677:cluster/dop-dev-ops-project
make deploy_dev
```

# To Deploy
- Use the "service.yaml" instead of "load-balancer.yaml"
```
cd ../dop_client_react
make push

cd ../dop_server_flask
make push

cd ../dop_microservice
make push

cd ../dop_deployment

k config use-context minikube
make deploy_dev
```

Run `minikube service dop-client-react-service --url`. Then, open the browser at the giver URL (if using Minikube)
OR
Then, open the browser at http://localhost:30001 (if using Docker Desktop's Kubernetes)

## To test connectivity to AWS EKS cluster
curl http://<Load Balancer DNS name>:8000/api/

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
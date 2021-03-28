# To Deploy

```
cd ../dop_client_react
make push

cd ../dop_server_flask
make push

cd ../dop_microservice
make push

cd ../dop_deployment
make deploy
```

Then, open the browser at localhost:30001

# To redploy

To redeploy images, you need to run:

```
kubectl get pods
kubectl delete pod <pod-name>
```

This will trigger re-pullling of the docker image (since we set the imagePullPolicy to always)

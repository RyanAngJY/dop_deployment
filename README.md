cd client_react
make push

cd server_flask
make push

cd deployment
make fullstack

# To redploy

To redeploy images, you need to run:

```
kubectl get pods
kubectl delete pod <pod-name>
```

This will trigger re-pullling of the docker image (since we set the imagePullPolicy to always)

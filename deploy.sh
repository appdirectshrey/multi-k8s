docker build -t shrey7197/multi-client:latest -t shrey7197/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shrey7197/multi-server:latest -t shrey7197/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shrey7197/multi-worker:latest -t shrey7197/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shrey7197/multi-client:latest
docker push shrey7197/multi-server:latest
docker push shrey7197/multi-worker:latest

docker push shrey7197/multi-client:$SHA
docker push shrey7197/multi-server:$SHA
docker push shrey7197/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shrey7197/multi-server:$SHA
kubectl set image deployments/client-deployment client=shrey7197/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shrey7197/multi-worker:$SHA
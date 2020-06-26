docker build -t bvujicic/multi-client:latest -t bvujicic/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bvujicic/multi-server:latest -t bvujicic/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bvujicic/multi-worker:latest -t bvujicic/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bvujicic/multi-client:latest
docker push bvujicic/multi-server:latest
docker push bvujicic/multi-worker:latest
docker push bvujicic/multi-client:$SHA
docker push bvujicic/multi-server:$SHA
docker push bvujicic/multi-worker:$SHA

kubectl -f apply k8s
kubectl set image deployments/server-deployment server=bvujicic/multi-server:$SHA
kubectl set image deployments/client-deployment client=bvujicic/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bvujicic/multi-worker:$SHA

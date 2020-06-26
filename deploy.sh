docker build -t bvujicic/multi-client -f ./client/Dockerfile ./client
docker build -t bvujicic/multi-server -f ./server/Dockerfile ./server
docker build -t bvujicic/multi-worker -f ./worker/Dockerfile ./worker
docker push bvujicic/multi-client
docker push bvujicic/multi-server
docker push bvujicic/multi-worker

kubectl -f apply k8s
kubectl set image deployments/server-deployment server=bvujicic/multi-server


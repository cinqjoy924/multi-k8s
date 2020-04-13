docker build -t cinqjoy/multi-client:latest -t cinqjoy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cinqjoy/multi-server:latest -t cinqjoy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cinqjoy/multi-worker:latest -t cinqjoy/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push cinqjoy/multi-client:latest
docker push cinqjoy/multi-server:latest
docker push cinqjoy/multi-worker:latest
docker push cinqjoy/multi-client:$SHA
docker push cinqjoy/multi-server:$SHA
docker push cinqjoy/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cinqjoy/multi-server:$SHA
kubectl set image deployments/client-deployment client=cinqjoy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cinqjoy/multi-worker:$SHA

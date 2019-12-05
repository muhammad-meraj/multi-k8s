docker build -t meraj90/multi-client:latest -t meraj90/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t meraj90/multi-server:latest -t meraj90/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t meraj90/multi-worker:latest -t meraj90/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push meraj90/multi-client:latest
docker push meraj90/multi-server:latest
docker push meraj90/multi-worker:latest

docker push meraj90/multi-client:$SHA
docker push meraj90/multi-server:$SHA
docker push meraj90/multi-worker:$SHA

kubectl apply -f k8
kubectl set image deployments/server-deployment server=meraj90/multi-server:$SHA
kubectl set image deployments/client-deployment client=meraj90/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=meraj90/multi-worker:$SHA
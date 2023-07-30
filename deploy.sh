docker build -t muretimartin/multi-client:latest -t muretimartin/multiclient:$SHA -f ./client/Dockerfile ./client
docker build -t muretimartin/multi-server:latest -t muretimartin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t muretimartin/multi-worker:latest -t muretimartin/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push muretimartin/multi-client:latest
docker push muretimartin/multi-server:latest
docker push muretimartin/multi-worker:latest

docker push muretimartin/multi-client:$SHA
docker push muretimartin/multi-server:$SHA
docker push muretimartin/multi-worker:$SHA
 
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=muretimartin/multi-server:$SHA
kubectl set image deployments/client-deployment client=muretimartin/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=muretimartin/multi-worker:$SHA

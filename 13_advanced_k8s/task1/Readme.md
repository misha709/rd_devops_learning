#### [Back to Readme](../Readme.md)


## Task 1: Redis StatefulSet Cluster

### Prerequisites
- Kind installed and configured

### Step 1: Setup namespace and redis cluster

```powershell
cd ./k8s
kubectl apply -f .\namespace.yml -f .\redis-statefull-set.yaml
```

![Apply redis setup result](./images/apply-redis-setup.png)

When all pods are created run job to configure redis cluster

```powershell
cd ./k8s
kubectl apply -f redis-init-job.yml
```
![redis-init-job logs](./images/redis-init.png)

### Step 2: Test Redis Cluster Data Persistence

Set key to redis-0 pod

```powershell
kubectl exec -it redis-0 -n redis -- redis-cli -c SET mykey "hello world"
```

![Set my Key](./images/set-mykey-redis-0.png)

Get `mykey` from redis-1 to verify cluster replication

```powershell
kubectl exec -it redis-1 -n redis -- redis-cli -c GET mykey
```

![Get my key from redis-1](./images/get-mykey-redis-1.png)

Terminate pod redis-2 to test persistence

```powershell
kubectl delete pod redis-2 -n redis
```
![Terminate pod - redis-2](./images/terminating-pod-1.png)

Get key after re-create of the pod to verify StatefulSet persistence

```powershell
kubectl exec -it redis-2 -n redis -- redis-cli -c GET mykey
```

![Get my key from redis-2](./images/get-mykey-redis-2.png)
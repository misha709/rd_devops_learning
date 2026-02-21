## Task 0: Setup k8s cluster

To setup cluster use [Kind](https://kind.sigs.k8s.io/) - cli tool that allow to speen up clusters using docker.
Each task contains kind folder with appropriate scripts to setup clusers.

```powershell
./kind/CreateKindCluster.ps1

kubectl get nodes
```

![Created cluster](./images/created-cluster.png)

## Task 1: [Creating StatefulSet for Redis cluster](task1/Readme.md)

## Task 2: [Falco Security Monitoring with DaemonSet](task2/Readme.md)

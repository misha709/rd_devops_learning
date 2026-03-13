# AWS EKS

## [Task Description](TASK.md)

---

## Step 0 — Prerequisites

- For installing the cluster use `eksctl` — [GitHub](https://github.com/eksctl-io/eksctl)
- > **Note:** Attempt to set up cluster via Terraform — currently not successful.

---

## Step 1 — Create EKS Cluster

Install cluster using `eksctl`:

```powershell
eksctl create cluster `
  --name rd-mi-cluster `
  --version 1.35 `
  --region eu-west-1 `
  --nodegroup-name rd-cluster-nodes `
  --node-type t3.medium `
  --nodes 2
```

`eksctl` automatically installs credentials for `kubectl`. To connect, just switch the context.

Use [`kubectx`](https://github.com/ahmetb/kubectx) to switch contexts.

If credentials are not set up, run:

```powershell
aws eks update-kubeconfig --region eu-west-1 --name rd-mi-cluster
```

**Aliases configured for future use:**

| Alias | Command    |
|-------|------------|
| `k`   | `kubectl`  |
| `kx`  | `kubectx`  |
| `kn`  | `kubens`   |

---

## Step 2 — Verify Cluster Nodes

Get cluster nodes from local machine:

```powershell
k get nodes
```

![List of nodes](images/nodes_list.png)

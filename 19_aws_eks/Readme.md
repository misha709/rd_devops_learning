# AWS EKS

## [Task Description](TASK.md)

---

## Step 0 — Prerequisites

- For installing the cluster use `eksctl` — [GitHub](https://github.com/eksctl-io/eksctl)

> **Note:** Attempt to set up cluster via Terraform — currently not successful.

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


---

## Step 3 — Deploy Static Site

Apply site configuration, which includes:
- **ConfigMap** — provides the static `index.html` content
- **Deployment** — runs 2 nginx replicas serving the site
- **Service** (LoadBalancer) — exposes the site via a public AWS ELB

```powershell
k apply -f ./k8s/site.yaml
```

![Apply site configuration result](images/apply-site-configuration.png)

Get the external IP from `site-loadbalancer`:

```powershell
k get svc
```

![Get services result](images/get_services_result.png)

Verify the site is reachable (replace with your ELB hostname from `k get svc`):

```powershell
curl http://<elb-hostname>.eu-west-1.elb.amazonaws.com
```

![Site result](images/site-result.png)
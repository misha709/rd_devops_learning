# AWS EKS — Task Description

1. **Create an EKS Cluster**
   - Using AWS Management Console or CLI, create an EKS cluster
   - The cluster must consist of at least two worker nodes (Node Groups) in a public subnet
   - Use EC2 instance type `t3.medium`

2. **Configure kubectl for Cluster Access**
   - Connect local `kubectl` to your cluster
   - Verify that `kubectl get nodes` shows the cluster worker nodes

3. **Deploy a Static Website**
   - Create a Deployment that deploys a static website based on the `nginx` image
   - Use a ConfigMap to pass website files (e.g., `index.html`)
   - Deploy a Service of type `LoadBalancer` to make the website accessible via a public IP

4. **Create a PersistentVolumeClaim for Data Storage**
   - Use dynamic storage provisioning (StorageClass) to create a PersistentVolumeClaim
   - Deploy a Pod that uses this PVC to store data on an EBS disk

5. **Run a Task Using a Job**
   - Create a Job that executes a simple command, e.g., `echo "Hello from EKS!"`
   - Verify that the Job completes successfully

6. **Deploy a Test Application**
   - Deploy an application from the `httpd` (Apache HTTP Server) or `nginx` image
   - Use a Deployment to create two replicas
   - Configure a Service of type `ClusterIP` to access the application within the cluster

7. **Work with Namespaces**
   - Create a separate namespace `dev` and deploy an application with 5 replicas based on the `busybox` image. The container must run the command `sleep 3600`.

8. **Clean Up Resources**
   - Remove Deployment, Pod, Service, PVC, etc. after completing the work

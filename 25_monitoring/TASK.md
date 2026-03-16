# Setting up Monitoring for Web Server or Database Server

## Situation Description

Imagine you work as a DevOps engineer in a company that supports web applications and databases. To ensure infrastructure stability, you need to set up a monitoring system with Prometheus and Grafana, as well as a log collection system with Loki. Your task is to configure monitoring for one of the servers (web server or database server), collect metrics and logs, and visualize them in Grafana.

## Execution Requirements

### 1. Infrastructure

* You have access to AWS to create EC2 servers
* You need to create:
  * Monitoring server for Prometheus, Grafana, and Loki
  * Web server or database server that needs to be monitored
* Servers must be located in the same VPC

### 2. Server Requirements

**Monitoring Server:**
* Instance type: t3.small
* Open ports:
  * 22 (SSH)
  * 9090 (Prometheus)
  * 3000 (Grafana)
  * 3100 (Loki)

**Web Server or Database Server:**
* Instance type: t3.micro
* Deploy:
  * Nginx or MySQL
* Open ports:
  * 22 (SSH)
  * 80 (for Nginx) or 3306 (for MySQL)
  * 9100 (Node Exporter)

## Tasks

### 1. Deploy Infrastructure

**Monitoring Server:**
* Install Docker and Docker Compose
* Launch the following services:
  * Prometheus: for collecting metrics
  * Grafana: for visualizing metrics and logs
  * Loki: for storing logs
  * Promtail: for collecting logs

**Web Server or Database Server:**
* Install Nginx or MySQL
* Install Node Exporter for collecting metrics
* Configure Promtail to collect system logs or service logs (e.g., Nginx or MySQL)

### 2. Configure Prometheus

On the monitoring server:
* Configure to collect metrics from Node Exporter and other sources

### 3. Configure Loki

On the monitoring server:
* Configure loki-config.yml for storing logs

On the web server or database server:
* Configure promtail-config.yml for collecting logs

### 4. Configure Grafana

1. Open Grafana: http://<Monitoring_Server_IP>:3000
2. Add data sources:
   * Prometheus: http://prometheus:9090
   * Loki: http://loki:3100
3. Import dashboards:
   * Node Exporter Dashboard (ID: 1860)
   * Nginx Dashboard (for web server)
   * MySQL Dashboard (for database server)
   * Loki Logs Explorer

## Expected Results

In Grafana, the following should be available:

* Metrics from Node Exporter for the selected server (CPU, RAM, Disk, Network)
* Logs from the selected server, collected by Promtail through Loki
* Additional metrics (e.g., HTTP requests for Nginx or database statistics for MySQL)

The configuration should be integrated and work stably.

## Additional Requirements (Optional)

1. Configure alerts in Grafana based on metrics or logs (e.g., HTTP 5xx errors or high CPU load)
2. Add another server for monitoring (web server or database server)
3. Use HTTPS for Grafana access
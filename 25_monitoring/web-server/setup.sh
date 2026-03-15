#!/bin/bash

# Web Server Setup Script for Monitoring
# This script installs and configures Nginx, Node Exporter, Nginx Exporter, and Promtail

set -e

echo "=== Starting Web Server Setup ==="

# Update system
echo "Updating system packages..."
sudo apt-get update
sudo apt-get upgrade -y

# Install Nginx
echo "Installing Nginx..."
sudo apt-get install -y nginx

# Configure Nginx stub_status for metrics
echo "Configuring Nginx stub_status..."
sudo tee /etc/nginx/sites-available/stub_status > /dev/null <<'EOF'
server {
    listen 8080;
    server_name localhost;

    location /stub_status {
        stub_status on;
        access_log off;
        allow 127.0.0.1;
        deny all;
    }
}
EOF

sudo ln -sf /etc/nginx/sites-available/stub_status /etc/nginx/sites-enabled/stub_status
sudo nginx -t
sudo systemctl restart nginx

# Install Node Exporter
echo "Installing Node Exporter..."
NODE_EXPORTER_VERSION="1.8.2"
cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
tar -xzf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
sudo mv node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter /usr/local/bin/
rm -rf node_exporter-${NODE_EXPORTER_VERSION}*

# Create Node Exporter systemd service
sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<'EOF'
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=nobody
Group=nogroup
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

# Install Nginx Prometheus Exporter
echo "Installing Nginx Prometheus Exporter..."
NGINX_EXPORTER_VERSION="1.3.0"
cd /tmp
wget https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v${NGINX_EXPORTER_VERSION}/nginx-prometheus-exporter_${NGINX_EXPORTER_VERSION}_linux_amd64.tar.gz
tar -xzf nginx-prometheus-exporter_${NGINX_EXPORTER_VERSION}_linux_amd64.tar.gz
sudo mv nginx-prometheus-exporter /usr/local/bin/
rm -f nginx-prometheus-exporter_${NGINX_EXPORTER_VERSION}_linux_amd64.tar.gz

# Create Nginx Exporter systemd service
sudo tee /etc/systemd/system/nginx_exporter.service > /dev/null <<'EOF'
[Unit]
Description=Nginx Prometheus Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=nobody
Group=nogroup
Type=simple
ExecStart=/usr/local/bin/nginx-prometheus-exporter -nginx.scrape-uri=http://localhost:8080/stub_status

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable nginx_exporter
sudo systemctl start nginx_exporter

# Install Promtail
echo "Installing Promtail..."
PROMTAIL_VERSION="3.0.0"
cd /tmp
wget https://github.com/grafana/loki/releases/download/v${PROMTAIL_VERSION}/promtail-linux-amd64.zip
sudo apt-get install -y unzip
unzip promtail-linux-amd64.zip
sudo mv promtail-linux-amd64 /usr/local/bin/promtail
sudo chmod +x /usr/local/bin/promtail
rm promtail-linux-amd64.zip

# Create Promtail config directory
sudo mkdir -p /etc/promtail

# Note: You need to copy promtail-config.yml to /etc/promtail/config.yml manually
# and update MONITORING_SERVER_PRIVATE_IP with the actual IP

# Create Promtail systemd service
sudo tee /etc/systemd/system/promtail.service > /dev/null <<'EOF'
[Unit]
Description=Promtail service
After=network.target

[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/promtail -config.file=/etc/promtail/config.yml
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
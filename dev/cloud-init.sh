#!/bin/bash
set -e

# Log the provisioning process for troubleshooting.
exec > >(tee -a /var/log/cloud-init-app.log) 2>&1

echo "Starting VMSS initialization..."

apt-get update -y
apt-get install -y docker.io curl

systemctl enable --now docker

docker pull egamor/auto-scaling-demo-app-nodejs:1.0

docker run -d \
  --name auto-scaling-demo \
  --restart unless-stopped \
  -p 80:3000 \
  egamor/auto-scaling-demo-app-nodejs:1.0

echo "VMSS initialization completed."
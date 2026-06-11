#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
INSTANCE_ID=$(terraform -chdir=terraform output -raw instance_id)
PUBLIC_IP=$(terraform -chdir=terraform output -raw public_ip)

echo "Rebooting instance ${INSTANCE_ID} with AWS CLI..."
aws ec2 reboot-instances --instance-ids "${INSTANCE_ID}"

echo "Waiting for instance status checks..."
aws ec2 wait instance-status-ok --instance-ids "${INSTANCE_ID}"

echo "Testing Minecraft after reboot on ${PUBLIC_IP}:25565"
nmap -sV -Pn -p T:25565 "${PUBLIC_IP}"

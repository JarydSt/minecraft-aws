#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
PUBLIC_IP=$(terraform -chdir=terraform output -raw public_ip)

echo "Testing Minecraft TCP port on ${PUBLIC_IP}:25565"
nmap -sV -Pn -p T:25565 "${PUBLIC_IP}"

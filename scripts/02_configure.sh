#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

PUBLIC_IP=$(terraform -chdir=terraform output -raw public_ip)

cat > ansible/inventory.yml <<EOF_INVENTORY
minecraft:
  hosts:
    minecraft-server:
      ansible_host: ${PUBLIC_IP}
      ansible_user: ec2-user
      ansible_ssh_private_key_file: ../.ssh/minecraft_key
      ansible_python_interpreter: /usr/bin/python3
EOF_INVENTORY

echo "Generated ansible/inventory.yml for ${PUBLIC_IP}"
echo "Waiting for SSH to become available for Ansible..."

for i in {1..30}; do
  if ssh -o StrictHostKeyChecking=no -o BatchMode=yes -o ConnectTimeout=5 -i .ssh/minecraft_key ec2-user@"${PUBLIC_IP}" "echo ready" >/dev/null 2>&1; then
    break
  fi
  sleep 10
  if [[ "$i" == "30" ]]; then
    echo "Timed out waiting for SSH. Check your AWS credentials, security group, and TF_VAR_admin_cidr."
    exit 1
  fi
done

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansible/inventory.yml ansible/playbook.yml

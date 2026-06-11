#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

if [[ ! -f .ssh/minecraft_key.pub ]]; then
  echo "Missing .ssh/minecraft_key.pub. Run ./scripts/00_generate_key.sh first."
  exit 1
fi

if [[ -z "${TF_VAR_admin_cidr:-}" ]]; then
  MY_IP=$(curl -fsS https://checkip.amazonaws.com | tr -d '\n')
  export TF_VAR_admin_cidr="${MY_IP}/32"
  echo "TF_VAR_admin_cidr was not set. Using detected IP: ${TF_VAR_admin_cidr}"
else
  echo "Using TF_VAR_admin_cidr=${TF_VAR_admin_cidr}"
fi

terraform -chdir=terraform init
terraform -chdir=terraform apply -auto-approve

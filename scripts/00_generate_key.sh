#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
mkdir -p .ssh

if [[ -f .ssh/minecraft_key ]]; then
  echo "Key already exists at .ssh/minecraft_key"
else
  ssh-keygen -t ed25519 -f .ssh/minecraft_key -N "" -C "minecraft-iac-key"
  chmod 600 .ssh/minecraft_key
  chmod 644 .ssh/minecraft_key.pub
  echo "Created .ssh/minecraft_key and .ssh/minecraft_key.pub"
fi

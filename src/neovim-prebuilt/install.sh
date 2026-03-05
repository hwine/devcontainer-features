#!/bin/sh
set -e

echo "Activating feature 'neovim'"

VERSION=${VERSION:-stable}

if ! command -v curl >/dev/null 2>&1; then
  echo "curl not found, attempting to install with apt..."
  apt-get update && apt-get install -y curl
fi

case $(uname --machine) in
  x86_64|amd64) arch=x86_64 ;;
  aarch64|arm64) arch=arm64 ;;
  *) echo "Unknown architecture '$(uname --machine)'" &>2 ; exit 1 ;;
esac

echo "Installing version: $VERSION for $arch"

STABLE_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$arch.tar.gz"
NIGHTLY_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-$arch.tar.gz"

case $VERSION in
stable)
  URL=$STABLE_URL
  ;;
nightly)
  URL=$NIGHTLY_URL
  ;;
v*)
  URL="https://github.com/neovim/neovim/releases/download/$VERSION/nvim-linux-$arch.tar.gz"
  ;;
*)
  echo "Unknown version: $VERSION" >&2
  exit 1
  ;;
esac

curl -LO $URL
rm -rf /opt/nvim-linux-$arch
tar -C /opt -xzf nvim-linux-$arch.tar.gz
# execute the binary from here to pick up other dirs
cat >/bin/nvim <<EOF
#!/usr/bin/env sh
# Use neovim installed via devcontainer
exec /opt/nvim-linux-$arch/bin/nvim "\$@"
EOF
chmod 555 /bin/nvim

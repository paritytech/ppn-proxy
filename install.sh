#!/bin/bash
#
# Product Preview Network - Quick Install
#
# Usage:
#   curl -sL https://raw.githubusercontent.com/paritytech/ppn-proxy/main/install.sh | bash
#   curl -sL https://raw.githubusercontent.com/paritytech/ppn-proxy/main/install.sh | bash -s -- [branch] [target-dir]
#
# Examples:
#   bash install.sh                    # Clone to ./ppn, start network
#   bash install.sh main               # Use specific branch
#   bash install.sh main my-ppn        # Clone to ./my-ppn
#   bash install.sh "" my-ppn          # Default branch, custom directory
#
# Prerequisites:
#   - GitHub auth: gh auth login (or set GITHUB_TOKEN)
#   - Node.js 20+ (for elastic scaling core assignment)
#
# After install, from target directory:
#   make start   - Start the network
#   make clean   - Remove binaries
#   make fresh   - Clean and restart
#   make help    - Show all commands
#

set -e

BRANCH="${1:-main}"
TARGET="${2:-ppn}"

echo "Product Preview Network Installer"
echo "================================="
echo ""
echo "Branch: $BRANCH"
echo "Target: ./$TARGET"
echo ""

# Clone the repository
if [ -d "$TARGET" ]; then
    echo "Directory '$TARGET' already exists."
    echo "To reinstall, remove it first: rm -rf $TARGET"
    exit 1
fi

echo "Cloning product-preview-net..."
git clone --depth 1 --branch "$BRANCH" \
    https://github.com/paritytech/product-preview-net.git "$TARGET"

# Remove unnecessary files
rm -rf "$TARGET/.git" "$TARGET/.github" "$TARGET/server"

pushd "$TARGET" > /dev/null
make ensure-deps
popd > /dev/null

echo "To start the network, run: "
echo "cd $TARGET && make start\` or \`make help\` for more options."
echo "or run network directly: \`BIN=${TARGET}/bin SCRIPTS=${TARGET}/scripts ${TARGET}/bin/zombie-cli spawn -p native ${TARGET}/bin/local-dev.toml"
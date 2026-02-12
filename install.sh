#!/bin/bash
#
# Product Preview Network - Quick Install
#
# Usage:
#   curl -sL https://raw.githubusercontent.com/paritytech/ppn-proxy/main/install.sh | bash
#   curl -sL https://raw.githubusercontent.com/paritytech/ppn-proxy/main/install.sh | bash -s -- [branch] [target-dir] [ppn-tag]
#
# Examples:
#   bash install.sh                                    # Clone to ./ppn, latest release
#   bash install.sh main                               # Use specific branch
#   bash install.sh main my-ppn                        # Clone to ./my-ppn
#   bash install.sh main ppn v20250210.183045          # Pin to specific release
#   bash install.sh "" "" v20250210.183045             # Default branch/dir, specific release
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
PPN_TAG="${3:-}"

echo "Product Preview Network Installer"
echo "================================="
echo ""
echo "Branch: $BRANCH"
echo "Target: ./$TARGET"
if [ -n "$PPN_TAG" ]; then
    echo "PPN Tag: $PPN_TAG"
fi
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
if [ -n "$PPN_TAG" ]; then
    PPN_TAG="$PPN_TAG" make ensure-deps
else
    make ensure-deps
fi
popd > /dev/null

echo ""
echo "To start the network, run: \`cd $TARGET && make start\` or \`make help\` for more options."
echo ""
echo "To run network directly: \`BIN=$(realpath ${TARGET}/bin) SCRIPTS=$(realpath ${TARGET}/scripts) ${TARGET}/bin/zombie-cli spawn -p native ${TARGET}/bin/local-dev.toml\`"
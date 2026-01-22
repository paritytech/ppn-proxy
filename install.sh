# Check for cargo, install if missing
if ! command -v cargo &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# Check for zombie-cli, install if missing
if ! command -v zombie &> /dev/null; then
    cargo install zombie-cli
fi

# Fetch and generate product-preview-net configs
git clone --depth 1 git@github.com:paritytech/product-preview-net.git /tmp/ppn && \
bash /tmp/ppn/fetch.sh && \
bash /tmp/ppn/generate.sh && \
cp /tmp/ppn/zombienet-configs/local-dev.toml ./bin/ && \
rm -rf /tmp/ppn

echo "
To start the zombienet:

BIN=\$(pwd)/bin zombie-cli spawn -p native ./bin/local-dev.toml
"
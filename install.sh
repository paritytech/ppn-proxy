# Fetch and generate product-preview-net configs
git clone --depth 1 git@github.com:paritytech/product-preview-net.git /tmp/ppn && \
source /tmp/ppn/scripts/install.sh && \
bash /tmp/ppn/scripts/fetch.sh && \
bash /tmp/ppn/scripts/generate.sh && \
cp /tmp/ppn/zombienet-configs/local-dev.toml ./bin/ && \
rm -rf /tmp/ppn

echo "
To start the zombienet:

BIN=\$(pwd)/bin zombie-cli spawn -p native ./bin/local-dev.toml
"
# Optional branch argument
BRANCH="${1:-}"
BRANCH_FLAG=""
if [ -n "$BRANCH" ]; then
  BRANCH_FLAG="--branch $BRANCH"
fi

# Fetch and generate product-preview-net configs
rm -rf /tmp/ppn
git clone --depth 1 $BRANCH_FLAG https://github.com/paritytech/product-preview-net.git /tmp/ppn && \
source /tmp/ppn/scripts/install.sh && \
bash /tmp/ppn/scripts/fetch.sh && \
bash /tmp/ppn/scripts/generate.sh && \
cp /tmp/ppn/zombienet-configs/local-dev.toml ./bin/ && \
rm -rf /tmp/ppn
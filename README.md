# PPN Proxy

Quick installer for [Product Preview Network](https://github.com/paritytech/product-preview-net) - spin up a local Polkadot ecosystem with one command.

## Usage

```bash
curl -sL https://raw.githubusercontent.com/paritytech/ppn-proxy/main/install.sh | bash
```

This creates a `ppn/` folder with everything needed and starts the network.

### Options

```bash
# Custom branch
curl -sL .../install.sh | bash -s -- my-branch

# Custom directory
curl -sL .../install.sh | bash -s -- main my-network

# Or download and run
curl -sLO https://raw.githubusercontent.com/paritytech/ppn-proxy/main/install.sh
bash install.sh [branch] [target-dir]
```

## Prerequisites

- **GitHub auth**: `gh auth login` or set `GITHUB_TOKEN`
- **Node.js 20+**: For elastic scaling

## After Install

```bash
cd ppn

make start    # Start network
make clean    # Remove binaries
make fresh    # Clean and restart
make help     # Show all commands
```

## Endpoints

When running, connect to:

| Chain | WebSocket |
|-------|-----------|
| Relay Alice | `ws://127.0.0.1:10000` |
| Asset Hub | `ws://127.0.0.1:10020` |
| People Chain | `ws://127.0.0.1:10010` |
| Bulletin | `ws://127.0.0.1:10030` |

See [product-preview-net](https://github.com/paritytech/product-preview-net) for full documentation.

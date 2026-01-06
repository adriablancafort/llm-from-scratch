#!/bin/bash

source .venv/bin/activate

NANOCHAT_BASE_DIR="${NANOCHAT_BASE_DIR:-$HOME/.cache/nanochat}"

if [ ! -f "$NANOCHAT_BASE_DIR/model_sft.pt" ] && [ ! -f "$NANOCHAT_BASE_DIR/model_mid.pt" ] && [ ! -f "$NANOCHAT_BASE_DIR/model_base.pt" ]; then
    echo "No trained model found"
fi

# chat with the model over a pretty WebUI ChatGPT style
PUBLIC_IP=$(curl -s ifconfig.me 2>/dev/null || curl -s icanhazip.com 2>/dev/null || hostname -I | awk '{print $1}')

echo "Server running at: http://$PUBLIC_IP:8000"

python -m scripts.chat_web

# chat with the model over CLI. Leave out the -p to chat interactively
# python -m scripts.chat_cli -p "Why is the sky blue?"

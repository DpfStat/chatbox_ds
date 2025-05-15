#!/bin/bash

MODEL_URL="https://huggingface.co/TheBloke/deepseek-1.3B-Chat-GGUF/resolve/main/deepseek-1.3b-chat.Q4_K_M.gguf"
MODEL_DIR="./models"
mkdir -p $MODEL_DIR

echo "下载模型中..."
wget -q --show-progress -P $MODEL_DIR $MODEL_URL
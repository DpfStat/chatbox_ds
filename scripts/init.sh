#!/bin/bash

# 下载模型
MODEL_DIR="./models"
MODEL_FILE="deepseek-1.3b-chat.Q4_K_M.gguf"
MODEL_URL="https://huggingface.co/TheBloke/deepseek-1.3B-Chat-GGUF/resolve/main/deepseek-llm-7b-chat.Q4_K_M.gguf"
if [ ! -f "${MODEL_DIR}/${MODEL_FILE}" ]; then
  echo "模型未找到，开始下载..."
  ./scripts/download-model.sh
#   mkdir -p "${MODEL_DIR}"
#   wget -O "${MODEL_DIR}/${MODEL_FILE}" "${MODEL_URL}"
else
  echo "模型已存在，跳过下载。"
fi
#./scripts/download-model.sh

# 构建镜像
docker-compose build

# 初始化知识库
docker-compose up knowledge-init

# 启动服务
docker-compose up -d

# 打印访问信息
echo -e "\n\n部署完成！访问以下地址："
echo "网页界面: http://localhost:8080"
echo "Dify 控制台: http://localhost:3000"
#!/bin/bash

# 下载模型
./scripts/download-model.sh

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
# docker compose
1. download docker-compose-darwin-aarch64 from https://github.com/docker/compose/releases(because there is no docker-compose-Darwin-arm64)
2. mv docker-compose-darwin-aarch64 /usr/local/bin
3. cd /usr/local/bin
4. mv docker-compose-darwin-aarch64 docker-compose
5. sudo chmod +x /usr/local/bin/docker-compose
6. vim ~/.zshrc
7. DOCKER_COMPOSE_HOME=/usr/local/bin/docker-compose
8. source ~/.zshrc
9. docker-compose --version
source: https://blog.csdn.net/qq_39375971/article/details/139124737


# stop the container
docker compose down



cd dify/docker
git pull origin main
docker compose down
docker compose pull
docker compose up -d


https://blog.csdn.net/qq_44696532/article/details/135774657


# 1. 克隆官方仓库
git clone https://github.com/langgenius/dify.git
cd dify

# 2. 初始化环境配置
cp .env.example .env
echo "LOCAL_MODEL_ENABLED=true" >> .env

# 3. 启动服务
docker-compose up -d

# 4. 等待初始化完成(约3-5分钟)

ollama run deepseek-r1:7b

https://zhuanlan.zhihu.com/p/21050218655

https://mp.weixin.qq.com/s/SStDLIh-ciTIXn5nQ9AGUA

https://www.cnblogs.com/LaiYun/p/18808736

# ollama
ollama run deepseek-r1:7b
for docker model provider: http://host.docker.internal:11434
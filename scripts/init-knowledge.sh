#!/bin/bash

# 知识库初始化脚本
set -e  # 遇到错误立即退出

# 配置参数
DOC_DIR="/documents"          # 容器内文档目录
VECTOR_DIR="/vector_db"       # 容器内向量库目录
EMBED_MODEL="BAAI/bge-small-zh-v1.5"  # 嵌入模型
INDEX_NAME="my_knowledge"     # 索引名称

echo "===== 开始初始化知识库 ====="

# 安装 Python 依赖（包含文件类型检测支持）
pip install --upgrade dify-client \
    python-magic-bin \
    numpy==1.21.0 \
    huggingface-hub==0.19.4 \
    sentence-transformers==2.2.2 \
    faiss-cpu==1.7.4 \
    fastapi==0.104.1 \
    uvicorn==0.24.0.post1 \
    python-dotenv==1.0.0 \
    unstructured[md]


# 处理文档（支持 PDF/TXT/MD）
python3 - <<EOF
import os
from sentence_transformers import SentenceTransformer
import faiss
import numpy as np
from unstructured.partition.auto import partition

# 加载嵌入模型
embedder = SentenceTransformer('${EMBED_MODEL}')

# 遍历文档
texts = []
for filename in os.listdir('${DOC_DIR}'):
    if filename.lower().endswith(('.pdf', '.txt', '.md')):
        print(f"处理文件: {filename}")
        elements = partition(os.path.join('${DOC_DIR}', filename))
        texts += [str(el) for el in elements]

# 生成向量
embeddings = embedder.encode(texts, normalize_embeddings=True)
embeddings = embeddings.astype(np.float32)

# 创建 FAISS 索引
dim = embeddings.shape[1]
index = faiss.IndexFlatIP(dim)
index.add(embeddings)

# 保存索引和元数据
os.makedirs('${VECTOR_DIR}', exist_ok=True)
faiss.write_index(index, os.path.join('${VECTOR_DIR}', '${INDEX_NAME}.faiss'))
with open(os.path.join('${VECTOR_DIR}', 'metadata.txt'), 'w') as f:
    f.write('\n'.join(texts))

print(f"知识库构建完成！共处理 {len(texts)} 个文本块")
EOF

echo "===== 知识库初始化完成 ====="

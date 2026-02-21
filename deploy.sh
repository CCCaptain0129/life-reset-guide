#!/bin/bash

# 人生重置向导 - 部署脚本
# 用法: ./deploy.sh [环境]
# 环境: dev (默认), prod

set -e  # 遇到错误时退出

ENV=${1:-dev}
PROJECT_DIR="/var/www/life-reset-guide"
CODE_DIR="$PROJECT_DIR/code"
DEPLOY_DIR="$PROJECT_DIR/deploy"
BACKUP_DIR="$PROJECT_DIR/code-backup-20260221-1944"

echo "🚀 开始部署人生重置向导 ($ENV 环境)"
echo "========================================"

# 检查目录
echo "📁 检查项目目录..."
if [ ! -d "$CODE_DIR" ]; then
    echo "❌ 代码目录不存在: $CODE_DIR"
    exit 1
fi

cd "$CODE_DIR"

# 安装依赖（如果需要）
echo "📦 检查依赖..."
if [ ! -d "node_modules" ]; then
    echo "  安装依赖..."
    npm install
fi

# 构建项目
echo "🔨 构建Vue应用..."
npm run build

if [ $? -ne 0 ]; then
    echo "❌ 构建失败"
    exit 1
fi

echo "✅ 构建成功"

# 备份当前部署（如果是生产环境）
if [ "$ENV" = "prod" ]; then
    echo "💾 备份当前部署..."
    BACKUP_NAME="deploy-backup-$(date +%Y%m%d-%H%M%S)"
    if [ -d "$DEPLOY_DIR" ]; then
        cp -r "$DEPLOY_DIR" "$PROJECT_DIR/$BACKUP_NAME"
        echo "  备份到: $PROJECT_DIR/$BACKUP_NAME"
    fi
fi

# 部署到目标目录
echo "🚚 部署到: $DEPLOY_DIR"
rm -rf "$DEPLOY_DIR"
mkdir -p "$DEPLOY_DIR"
cp -r dist/* "$DEPLOY_DIR/"

# 复制模板文件（如果需要）
if [ -d "$BACKUP_DIR/templates" ]; then
    echo "📄 复制模板文件..."
    mkdir -p "$DEPLOY_DIR/templates"
    cp -r "$BACKUP_DIR/templates/"* "$DEPLOY_DIR/templates/"
fi

# 设置权限
echo "🔒 设置文件权限..."
chmod -R 755 "$DEPLOY_DIR"
chown -R www-data:www-data "$DEPLOY_DIR" 2>/dev/null || true

# 重新加载Nginx（如果是生产环境）
if [ "$ENV" = "prod" ]; then
    echo "🔄 重新加载Nginx..."
    /usr/sbin/nginx -t 2>/dev/null && {
        kill -HUP $(cat /var/run/nginx.pid 2>/dev/null || pgrep nginx | head -1) 2>/dev/null
        echo "✅ Nginx配置已重新加载"
    } || {
        echo "⚠️  Nginx配置检查失败，请手动检查"
    }
fi

echo "========================================"
echo "🎉 部署完成！"
echo "🌐 网站地址: https://life-reset-guide.com"
echo "📁 部署目录: $DEPLOY_DIR"
echo "🕐 部署时间: $(date)"
echo "========================================"

# 健康检查
echo "🏥 执行健康检查..."
sleep 2
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://life-reset-guide.com || echo "000")

if [ "$HTTP_STATUS" = "200" ]; then
    echo "✅ 网站可正常访问 (HTTP $HTTP_STATUS)"
else
    echo "⚠️  网站访问异常 (HTTP $HTTP_STATUS)"
    echo "   请检查: https://life-reset-guide.com"
fi
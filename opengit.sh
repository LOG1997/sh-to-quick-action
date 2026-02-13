#!/bin/bash

# 检查当前目录是否是Git仓库
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "⚠️ 警告：当前目录不是Git仓库，无法获取远程地址！"
    exit 1
fi

# 获取第一个远程仓库的URL（优先取origin）
REMOTE_URL=$(git remote get-url origin 2>/dev/null)

# 检查是否获取到远程地址
if [ -z "$REMOTE_URL" ]; then
    # 尝试获取任意远程仓库的URL（如果origin不存在）
    REMOTE_URL=$(git remote get-url $(git remote | head -n1) 2>/dev/null)
    # 仍未获取到则警告退出
    if [ -z "$REMOTE_URL" ]; then
        echo "⚠️ 警告：当前Git仓库未配置任何远程地址（git remote）！"
        exit 1
    fi
fi

# 转换远程URL为浏览器可访问的HTTPS地址（兼容SSH/HTTPS格式）
# 处理SSH格式（如 git@github.com:username/repo.git）
if [[ "$REMOTE_URL" =~ ^git@ ]]; then
    # 替换git@xxx.com: → https://xxx.com/，并去掉.git后缀
    BROWSER_URL=$(echo "$REMOTE_URL" | sed -e 's/git@//' -e 's/:/\//' -e 's/\.git$//')
    BROWSER_URL="https://$BROWSER_URL"
# 处理HTTPS格式（如 https://github.com/username/repo.git）
elif [[ "$REMOTE_URL" =~ ^https:// ]]; then
    # 仅去掉.git后缀
    BROWSER_URL=$(echo "$REMOTE_URL" | sed -e 's/\.git$//')
else
    echo "⚠️ 警告：不支持的远程地址格式：$REMOTE_URL"
    exit 1
fi

# 使用系统默认浏览器打开地址
echo "🔗 正在打开远程仓库地址：$BROWSER_URL"
xdg-open "$BROWSER_URL"

# 检查浏览器打开是否成功
if [ $? -eq 0 ]; then
    echo "✅ 已成功用默认浏览器打开远程仓库地址！"
else
    echo "❌ 错误：打开浏览器失败，请手动访问：$BROWSER_URL"
fi
#!/bin/bash

# 检查xclip是否安装
if ! command -v xclip >/dev/null 2>&1; then
    echo "错误：未安装xclip！请先执行以下命令安装："
    echo "Ubuntu/Debian: sudo apt update && sudo apt install -y xclip"
    echo "CentOS/RHEL: sudo yum install -y xclip"
    exit 1
fi

# 检查是否传入参数
if [ $# -eq 0 ]; then
    echo "错误：请传入文件名或文件路径！"
    echo "用法：$0 <文件名/文件路径>"
    echo "示例："
    echo "  $0 vite.js"
    echo "  $0 ~/projects/test.js"
    exit 1
fi

# 定义传入的文件路径
FILE_PATH="$1"

# 检查路径是否存在
if [ ! -e "$FILE_PATH" ]; then
    echo "错误：文件 '$FILE_PATH' 不存在！"
    exit 1
fi

# 检查路径是否是文件（禁止传入目录）
if [ -d "$FILE_PATH" ]; then
    echo "错误：'$FILE_PATH' 是目录！请传入文件名或文件路径，不能是目录。"
    exit 1
fi

# 核心操作：1. 复制文件内容到剪贴板 2. 终端输出文件内容
echo "========== 文件内容 =========="
cat "$FILE_PATH" | tee >(xclip -selection clipboard -i)
echo -e "\n========== 复制结果 =========="
echo "✅ 已将文件 '$FILE_PATH' 的内容复制到剪贴板！"
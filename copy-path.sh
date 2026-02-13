#!/bin/bash

# 检查Linux剪贴板工具xclip是否安装
if ! command -v xclip >/dev/null 2>&1; then
  echo "错误：未安装xclip！请先执行以下命令安装："
  echo "Ubuntu/Debian: sudo apt update && sudo apt install -y xclip"
  echo "CentOS/RHEL: sudo yum install -y xclip"
  exit 1
fi

# 定义Linux剪贴板命令（固定使用xclip）
COPY_CMD="xclip -selection clipboard"

# 获取执行脚本时的当前目录绝对路径
CURRENT_DIR=$(pwd)

# 处理输入参数逻辑
if [ $# -eq 0 ]; then
  # 无参数时，复制当前目录路径
  TARGET_PATH="$CURRENT_DIR"
elif [ "$1" = "." ] || [ "$1" = "./" ]; then
  # 输入.或./，复制当前目录路径
  TARGET_PATH="$CURRENT_DIR"
else
  # 输入是具体文件名，拼接完整路径（自动去除./前缀）
  CLEAN_INPUT=$(echo "$1" | sed 's/^\.\///')
  TARGET_PATH="$CURRENT_DIR/$CLEAN_INPUT"

  # 可选：检查文件是否存在（取消注释启用）
  # if [ ! -e "$TARGET_PATH" ]; then
  #     echo "警告：文件 $TARGET_PATH 不存在！但仍会复制该路径到剪贴板"
  # fi
fi

# 复制路径到剪贴板（-n 避免末尾多出换行符）
echo -n "$TARGET_PATH" | $COPY_CMD

# 输出提示
echo "已复制路径到剪贴板：$TARGET_PATH"

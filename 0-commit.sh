#!/bin/bash

# 检查是否有要提交的更改
if [[ -n $(git status -s) ]]; then
    # 添加所有更改
    git add .

    # 获取计算机的用户名
    username=$(whoami)

    # 提交更改，使用包含用户名的commit message
    git commit -m "commit by $username"

    # 拉取远程更改
    git fetch origin main

    # 检查是否有冲突
    if ! git diff --quiet HEAD..origin/main; then
        echo "Branch has been modified by others. Attempting to merge..."
        git pull origin main
        if [[ $? -ne 0 ]]; then
            echo "Merge conflicts detected. Please resolve them and commit again."
            exit 1
        fi
    fi

    # 推送到远程仓库
    git push origin main
else
    echo "No changes to commit."
fi
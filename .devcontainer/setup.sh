#!/bin/bash

echo "🔄 Setting up VSCode Dev Container..."

# VSCode拡張機能の強制インストール（念のため）
echo "📦 Installing VSCode Extensions..."
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-python.flake8
code --install-extension charliermarsh.ruff
code --install-extension ms-python.black-formatter
code --install-extension ms-python.isort

# Pythonの必要なツールをインストール
echo "🐍 Installing Python dependencies..."
pip install --upgrade pip
pip install flake8 ruff black isort

# LeetCode拡張機能の設定
echo "⚙️ Configuring LeetCode settings..."
mkdir -p ~/.config/leetcode
echo '{"defaultLanguage": "python3"}' > ~/.config/leetcode/user.json

echo "✅ Setup Complete!"
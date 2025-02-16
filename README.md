# leetcode-solutions


### 環境構築
### **`devcontainer.json` の配置場所**
`devcontainer.json` は **`.devcontainer/` フォルダ** の中に配置するのが一般的です。  

#### **配置パス**
```
your-repo/
│── .devcontainer/      ← ここに配置
│   ├── devcontainer.json
│   ├── Dockerfile      (必要なら)
│── easy/
│   ├── two_sum.py
│── medium/
│── hard/
│── README.md
```

---

### **1. `devcontainer.json` を作成する**
#### **VSCodeで直接作成**
1. **VSCodeでリポジトリを開く**
2. `.devcontainer` フォルダを作成
3. その中に `devcontainer.json` を作成し、以下を記述

```json
{
  "name": "LeetCode Python",
  "image": "mcr.microsoft.com/devcontainers/python:3.10", 
  "extensions": [
    "LeetCode.vscode-leetcode",
    "ms-python.python",
    "ms-python.vscode-pylance",
    "GitHub.copilot",
    "formulahendry.code-runner",
    "CoenraadS.bracket-pair-colorizer-2",
    "aaron-bond.better-comments",
    "usernamehw.errorlens"
  ],
  "settings": {
    "leetcode.defaultLanguage": "python3",
    "python.languageServer": "Pylance"
  }
}
```

---

### **2. Codespacesで`.devcontainer.json` を適用**
#### **方法1: Codespacesを開いてリロード**
1. **GitHubリポジトリで Codespaces を開く**
2. `.devcontainer/devcontainer.json` を作成 or 編集
3. **VSCodeの左下に「Rebuild Container」ボタンが出るのでクリック**
   - これで新しい環境が適用される

#### **方法2: 手動でコンテナを再構築**
1. **`Ctrl + Shift + P`（Mac: `Cmd + Shift + P`）を押す**
2. `Dev Containers: Rebuild and Reopen in Container` を選択

---

### **3. Dockerfileをカスタマイズ（オプション）**
より細かい環境設定をしたい場合、`.devcontainer/Dockerfile` も作成できます。

```dockerfile
# Python 3.10 ベースの開発環境
FROM mcr.microsoft.com/devcontainers/python:3.10

# 必要なツールをインストール
RUN pip install --upgrade pip \
    && pip install pytest flake8 black isort
```

この場合、`devcontainer.json` でDockerfileを参照するように設定します。

```json
{
  "name": "LeetCode Python",
  "build": {
    "dockerfile": "Dockerfile"
  },
  "extensions": [
    "LeetCode.vscode-leetcode",
    "ms-python.python",
    "ms-python.vscode-pylance"
  ],
  "settings": {
    "leetcode.defaultLanguage": "python3"
  }
}
```

---

### **まとめ**
✔ `.devcontainer/devcontainer.json` を作成  
✔ **Codespacesで「Rebuild Container」を実行**  
✔ **Dockerfileを使う場合は `devcontainer.json` で指定**

これで、LeetCodeの開発環境をスムーズに構築できます！ 🚀

### **📌 実行権限を与えるタイミング**
`chmod +x .devcontainer/setup.sh` を実行するのは、**リポジトリに `setup.sh` を作成した直後** です。

1. `.devcontainer/setup.sh` を作成する
2. **ローカル or Codespaces内のターミナルで実行権限を付与**
   ```sh
   chmod +x .devcontainer/setup.sh
   ```
3. `git add` してコミット & プッシュ（リモートでも実行権限を維持）
   ```sh
   git add .devcontainer/setup.sh
   git commit -m "Add setup.sh with execution permissions"
   git push origin main
   ```

---

### **🔄 CodespacesでRebuild後も権限を維持する**
Gitのリポジトリに `.devcontainer/setup.sh` を含めておけば、**CodespacesをRebuildしても実行権限が維持されます。**

✅ **事前に権限を設定 → GitHubにプッシュ**  
✅ **リポジトリをクローンしても `setup.sh` に実行権限が残る**  
✅ **Rebuild時に `postCreateCommand` で自動実行される** 🚀

---

### **💡 実行権限が失われた場合**
もしリモート環境（Codespacesなど）で `setup.sh` の実行権限が失われていたら、再度以下を実行してください。

```sh
chmod +x .devcontainer/setup.sh
```

これを `postCreateCommand` に追加する方法もありますが、基本的には **ローカルで設定してGitにプッシュするのが最適** です！ 👍
# GitHub 推送指南

## 📋 当前状态

- ✅ 所有文档已提交
- ✅ README 已创建
- ⚠️ earthplugin_web/ 和 earthstudiowasm/ 目录未提交（有 1,689 个文件）

## 🚀 推送到 GitHub 的步骤

### 方法 1: 只推送文档（推荐）

如果你不想上传大量的 proto 文件：

```bash
# 1. 在 GitHub 上创建新仓库
# 访问 https://github.com/new
# 填写仓库名称，例如：earth-wasm-parser
# 选择 Public 或 Private
# 不要初始化 README（我们已经有了）

# 2. 添加远程仓库
git remote add origin https://github.com/YOUR_USERNAME/earth-wasm-parser.git

# 3. 推送代码
git push -u origin master
```

### 方法 2: 推送所有文件（包括 proto 文件）

如果想上传完整的 proto 文件：

```bash
# 1. 添加 proto 目录
git add earthplugin_web/ earthstudiowasm/

# 2. 提交
git commit -m "添加完整的 Proto 源文件"

# 3. 添加远程仓库
git remote add origin https://github.com/YOUR_USERNAME/earth-wasm-parser.git

# 4. 推送
git push -u origin master
```

### 方法 3: 使用 GitHub CLI

```bash
# 1. 安装 GitHub CLI（如果未安装）
# Ubuntu: sudo apt install gh

# 2. 登录
gh auth login

# 3. 创建仓库并推送
gh repo create earth-wasm-parser --public --source=. --remote=origin --push
```

## 📊 仓库大小预估

- 只推送文档：~100 KB
- 包含 proto 文件：~5 MB

## ⚠️ 注意事项

1. **GitHub 文件大小限制**：
   - 单个文件不超过 100 MB
   - 我们最大的文件：earthplugin_web.wasm (20 MB) ✅

2. **LFS 配置**（可选）：
   如果想更好地管理大文件：
   ```bash
   git lfs install
   git lfs track "*.wasm"
   git add .gitattributes
   git commit -m "配置 Git LFS"
   ```

3. **忽略敏感信息**：
   确保 `.gitignore` 配置正确

## 🎯 推荐的推送命令

```bash
# 查看状态
git status

# 如果需要添加 proto 文件
git add earthplugin_web/ earthstudiowasm/
git commit -m "添加 Proto 源文件"

# 添加远程仓库（替换 YOUR_USERNAME）
git remote add origin https://github.com/YOUR_USERNAME/earth-wasm-parser.git

# 推送
git push -u origin master
```

## 📝 后续维护

推送后，查看仓库：
```bash
gh repo view --web
```

或访问：
```
https://github.com/YOUR_USERNAME/earth-wasm-parser
```

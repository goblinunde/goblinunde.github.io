# GitHub 工作流模板

本目录包含 GitHub Actions 工作流模板。默认情况下，这些工作流不会自动触发——您需要手动启用它们。

## 📋 可用工作流

### `deploy.yml.example` - 自动部署到 GitHub Pages

此工作流会在推送到 `main` 分支时自动构建并部署博客到 GitHub Pages。

**启用方法：**

```bash
# 在仓库根目录执行
mv .github/workflows/deploy.yml.example .github/workflows/deploy.yml
```

**或者使用 Makefile：**

```bash
make enable-workflow
```

## ⚙️ 配置要求

### GitHub Pages 部署

1. 进入仓库的 **Settings** → **Pages**
2. 将 **Source** 设置为 **GitHub Actions**
3. 确保仓库设置了正确的 Pages 权限

### 环境变量（可选）

在 **Settings** → **Secrets and variables** → **Actions** 中可配置：

| 变量名 | 说明 |
|--------|------|
| `CUSTOM_DOMAIN` | 自定义域名（可选） |

## 🔒 为什么默认不启用？

作为模板仓库，我们希望：

1. **让用户主动选择**：不是所有用户都使用 GitHub Pages
2. **避免构建失败**：未配置时工作流会失败，影响用户体验
3. **灵活部署**：支持 Vercel、Docker、服务器等多种部署方式

## 📚 相关文档

- [部署指南](../docs/deployment.md)
- [Makefile 使用说明](../docs/getting-started.md#使用-makefile)

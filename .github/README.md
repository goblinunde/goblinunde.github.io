# Goblinunde Blog 导航与部署说明

这个文档是 GitHub 入口说明，用于快速跳转到博客源码、Makefile 命令、部署流程和现有文章整理。更完整的项目说明见根目录 [README.md](../README.md)。

站点地址：<https://goblinunde.github.io/>

## 快速跳转

- [项目入口](#项目入口)
- [Makefile 用法](#makefile-用法)
- [部署教程](#部署教程)
- [文章内容整理](#文章内容整理)
- [写作与维护流程](#写作与维护流程)
- [常用文件](#常用文件)

## 项目入口

| 入口 | 说明 |
| --- | --- |
| [../README.md](../README.md) | 根目录完整项目说明 |
| [../Makefile](../Makefile) | 本地开发、文章管理、构建和部署命令 |
| [../twilight.config.yaml](../twilight.config.yaml) | 站点标题、导航、侧边栏、主题、壁纸等配置 |
| [../astro.config.mjs](../astro.config.mjs) | Astro、Markdown 插件和部署 adapter 配置 |
| [../src/content/posts/](../src/content/posts/) | 所有文章 Markdown 源文件 |
| [../src/content.config.ts](../src/content.config.ts) | Astro Content Collections schema |
| [../.github/workflows/deploy.yml](./workflows/deploy.yml) | GitHub Pages 自动部署 workflow |

## Makefile 用法

所有命令都在仓库根目录执行。

```bash
make <target> VAR="value"
```

### 初始化与开发

| 命令 | 作用 |
| --- | --- |
| `make help` | 查看 Makefile 内置帮助 |
| `make setup` | 首次安装依赖并输出下一步提示 |
| `make guide` | 查看模板使用引导 |
| `make install` | 执行 `pnpm install` |
| `make dev` | 启动 Astro 开发服务器 |
| `make build` | 使用 `GITHUB_PAGES=true pnpm build` 构建静态站点 |
| `make preview` | 预览构建产物 |
| `make check` | 执行 `pnpm check` 和 `pnpm lint` |
| `make format` | 格式化 `src/` |
| `make clean` | 清理 `dist`、`.astro`、`node_modules/.astro` |

### 文章管理

| 命令 | 作用 |
| --- | --- |
| `make article TITLE="slug"` | 创建普通文章 |
| `make draft TITLE="slug"` | 创建草稿文章 |
| `make article-with-category TITLE="slug" CATEGORY="Mathematics"` | 创建文章并写入分类 |
| `make list` | 列出文章、日期、草稿状态和 Git 状态 |
| `make info FILE=文章.md` | 查看单篇文章 frontmatter 和摘要 |
| `make search KEYWORD="关键词"` | 搜索文章内容 |
| `make stats` | 统计总文章、已发布文章和草稿 |
| `make publish FILE=文章.md` | 发布单篇草稿 |
| `make publish-all` | 发布所有草稿 |
| `make set-date FILE=文章.md DATE=2026-05-09` | 修改发布时间 |
| `make set-updated FILE=文章.md` | 设置更新时间为今天 |
| `make set-category FILE=文章.md CATEGORY=Mathematics` | 修改分类 |
| `make add-tag FILE=文章.md TAG=PDE` | 追加标签 |
| `make encrypt FILE=文章.md` | 设置 `encrypted: true` |
| `make decrypt FILE=文章.md` | 设置 `encrypted: false` |
| `make edit FILE=文章.md` | 用 `$EDITOR` 打开文章 |
| `make rename FILE=旧名.md NEWNAME=新名.md` | 重命名文章 |
| `make delete FILE=文章.md` | 删除文章，会要求确认 |
| `make backup` | 备份 `src/content/posts/` 到 `backups/` |

### Git 与部署

| 命令 | 作用 |
| --- | --- |
| `make status` | 查看 Git 状态 |
| `make log` | 查看最近 10 条提交 |
| `make diff` | 查看未提交 diff |
| `make deploy MSG="提交信息"` | 添加全部变更、提交并推送到 `main` |
| `make quick-deploy` | 自动生成提交信息并推送到 `main` |
| `make push MSG="提交信息"` | 提交并推送源码到 `main` |
| `make deploy-only` | 只执行本地静态构建 |
| `make deploy-vercel` | 使用 Vercel CLI 部署 |
| `make deploy-docker` | 构建 Docker 镜像 |
| `make deploy-podman` | 构建 Podman 镜像 |
| `make deploy-server` | 构建后用 `rsync` 上传服务器 |
| `make enable-workflow` | 启用 GitHub Actions workflow 示例 |

注意：`make deploy`、`make quick-deploy`、`make push` 都会推送到 `main`。当前 workflow 会在 `main` 分支 push 后自动部署 GitHub Pages。

## 部署教程

### GitHub Pages

当前仓库使用 [deploy.yml](./workflows/deploy.yml) 自动部署到 GitHub Pages。

触发方式：

- push 到 `main`
- 在 GitHub Actions 页面手动执行 `workflow_dispatch`

workflow 关键流程：

1. Checkout 仓库。
2. 使用 `pnpm/action-setup@v4` 配置 pnpm。
3. 使用 Node.js 22。
4. 执行 `pnpm install`。
5. 执行 `pnpm build`，并设置 `GITHUB_PAGES=true`。
6. 上传 `dist/`。
7. 使用 `actions/deploy-pages@v4` 发布。

本地等价检查：

```bash
make build
```

推送部署：

```bash
git status
git add <changed-files>
git commit -m "your commit message"
git push origin main
```

或使用 Makefile：

```bash
make deploy MSG="Update blog content"
```

### Vercel

默认情况下，`astro.config.mjs` 在没有 `GITHUB_PAGES=true`、没有 `CF_PAGES=1` 时使用 Vercel adapter。

本地检查：

```bash
pnpm build
```

CLI 部署：

```bash
make deploy-vercel
```

Vercel Dashboard 推荐配置：

| 配置项 | 推荐值 |
| --- | --- |
| Framework Preset | `Astro` |
| Install Command | `pnpm install` |
| Build Command | `pnpm build` |
| Root Directory | 仓库根目录 |

### Cloudflare Pages

Cloudflare Pages 会自动注入 `CF_PAGES=1`，项目会切换到 `@astrojs/cloudflare` adapter。

本地检查：

```bash
CF_PAGES=1 pnpm build
```

Cloudflare Pages 推荐配置：

| 配置项 | 推荐值 |
| --- | --- |
| Framework Preset | `Astro` |
| Build Command | `pnpm build` |
| Build Output Directory | `dist` |
| Root Directory | 仓库根目录 |
| Node Version | `22` |
| pnpm Version | `9.14.4` |

### Docker、Podman 和服务器

Docker：

```bash
make deploy-docker
```

Podman：

```bash
make deploy-podman
```

服务器 rsync：

```bash
DEPLOY_SERVER=user@example.com DEPLOY_PATH=/var/www/blog make deploy-server
```

## 文章内容整理

当前博客统计：

```text
总文章数: 24
已发布: 24
草稿: 0
```

分类统计：

| 分类 | 数量 | 内容 |
| --- | ---: | --- |
| `Mathematics` | 15 | PDE、Evans PDE、数学分析、数值方法、PINN、LaTeX |
| `Programming` | 4 | 深度学习与神经网络 |
| `Linux` | 3 | 发行版、Fedora、DNF、桌面协议 |
| `Guides` | 2 | 博客模板与组件展示 |

### PDE 主线与科学机器学习

| 顺序 | 文章 |
| ---: | --- |
| 1 | [PDE 入门：从方程、模型到研究地图](../src/content/posts/pde-introduction-research-map.md) |
| 2 | [PDE 理论求解：经典方法、弱解与能量估计](../src/content/posts/pde-theoretical-methods-guide.md) |
| 3 | [PDE 数值求解入门：差分、有限元、有限体积与谱方法](../src/content/posts/pde-numerical-methods-introduction.md) |
| 4 | [PDE 数值模拟：从模型到可重复实验](../src/content/posts/pde-numerical-simulation-workflow.md) |
| 5 | [PDE 学习资源推荐：国内外教材、课程与路线](../src/content/posts/pde-learning-resources-textbooks.md) |
| 6 | [数学视角下的 PINN：用物理约束训练神经网络](../src/content/posts/pinn-math-physics-informed-neural-networks.md) |
| 7 | [fPINN：分数阶物理信息神经网络的数学与实现](../src/content/posts/fpinn-fractional-physics-informed-neural-networks.md) |

### Evans PDE 教材精读

| 顺序 | 文章 |
| ---: | --- |
| 1 | [Evans《偏微分方程》第二版：前言、书目信息与目录中译](../src/content/posts/evans-pde-frontmatter-zh.md) |
| 2 | [Chapter 1：Introduction 中译与学习注释](../src/content/posts/evans-pde-chapter-1-introduction-zh.md) |
| 3 | [Chapter 2：四类重要线性 PDE 中译与学习注释](../src/content/posts/evans-pde-chapter-2-four-important-linear-pdes-zh.md) |
| 4 | [Chapter 3：非线性一阶 PDE 学习整理](../src/content/posts/evans-pde-chapter-3-nonlinear-first-order-pdes-zh.md) |

Evans 系列建议：

- 文件名使用 `evans-pde-chapter-<n>-<topic>-zh.md`。
- 基础标签使用 `PDE`、`Evans`、`Study Notes`。
- 中译或译注稿加 `Translation`。
- 专题整理稿加具体主题标签，例如 `Nonlinear PDE`、`First-Order PDE`。

### 数学基础与 LaTeX

| 文章 | 方向 |
| --- | --- |
| [实分析的三性原理](../src/content/posts/real-analysis-principles.md) | Real Analysis、Measure Theory |
| [集合论中的抽屉原理](../src/content/posts/pigeonhole-principle.md) | Set Theory、Combinatorics |
| [数学拓扑学入门介绍](../src/content/posts/topology-intro.md) | Topology |
| [LaTeX 高级功能详解](../src/content/posts/latex-advanced.md) | LaTeX、Typography |

### 深度学习与神经网络

| 顺序 | 文章 |
| ---: | --- |
| 1 | [正则化与深度学习](../src/content/posts/regularization-deep-learning.md) |
| 2 | [卷积神经网络 (CNN) 完全指南](../src/content/posts/cnn-guide.md) |
| 3 | [循环神经网络 (RNN) 深度解析](../src/content/posts/rnn-guide.md) |
| 4 | [Transformer 与注意力机制详解](../src/content/posts/transformer-attention.md) |

### Linux 系统与桌面

| 顺序 | 文章 |
| ---: | --- |
| 1 | [Linux 发行版详细介绍](../src/content/posts/linux-distributions.md) |
| 2 | [Fedora 系统与 DNF 包管理器完全指南](../src/content/posts/fedora-dnf-guide.md) |
| 3 | [Linux 桌面系统与显示协议总结](../src/content/posts/linux-desktop-protocols.md) |

### 博客模板与组件

| 文章 | 状态 |
| --- | --- |
| [博客模板指南](../src/content/posts/guide/index.md) | `encrypted: true` |
| [博客自定义组件展示](../src/content/posts/components-showcase.md) | `pinned: true` |

## 写作与维护流程

推荐新增文章流程：

```bash
make article TITLE="new-post-slug"
make info FILE=new-post-slug.md
make dev
make build
git status
```

推荐 frontmatter：

```yaml
---
title: "文章标题"
published: 2026-05-09
updated: 2026-05-09
description: "一句话说明文章内容。"
cover: "/assets/images/cover_math_1.png"
tags: [PDE, Study Notes]
category: Mathematics
draft: false
lang: zh
---
```

维护规则：

- 文件名使用稳定英文 slug。
- `category` 保持少而稳定，优先使用 `Mathematics`、`Programming`、`Linux`、`Guides`。
- `tags` 使用英文标签，统一写法，例如 `PDE`、`Evans`、`Deep Learning`、`Linux`。
- 大改文章时补充 `updated`。
- 发布前运行 `make build`。
- 推送前确认 `git status` 只有预期变更。

## 常用文件

| 文件 | 用途 |
| --- | --- |
| [../src/content/posts/](../src/content/posts/) | 文章 Markdown |
| [../public/assets/images/](../public/assets/images/) | 封面、头像、壁纸等图片 |
| [../src/styles/markdown.css](../src/styles/markdown.css) | Markdown 正文样式 |
| [../src/styles/extension.css](../src/styles/extension.css) | 自定义扩展样式 |
| [../scripts/new-post.js](../scripts/new-post.js) | 新建文章脚本 |
| [../scripts/build-with-pagefind.cjs](../scripts/build-with-pagefind.cjs) | 构建并生成 Pagefind 索引 |
| [../References/PDE.pdf](../References/PDE.pdf) | Evans PDE 参考资料 |

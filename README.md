# Goblinunde Blog

这是 `goblinunde.github.io` 的博客源码仓库，基于 Astro 5、Svelte 5、Twilight / retypeset 风格模板维护。当前内容重点是数学、PDE、科学机器学习、深度学习、Linux 和博客组件实践。

站点地址：<https://goblinunde.github.io/>

这个 README 主要解决三件事：

- 如何用 `Makefile` 完成日常开发、文章管理和部署。
- 如何从现有文章中找到合适的阅读路线。
- 如何维护文章的 `category`、`tags` 和 frontmatter，使后续内容保持一致。

## 目录

- [项目结构](#项目结构)
- [快速开始](#快速开始)
- [Makefile 使用说明](#makefile-使用说明)
- [文章写作流程](#文章写作流程)
- [文章导览](#文章导览)
- [分类与标签整理](#分类与标签整理)
- [Frontmatter 规范](#frontmatter-规范)
- [部署说明](#部署说明)
- [维护检查表](#维护检查表)

## 项目结构

```text
.
├── Makefile                    # 项目维护入口：开发、构建、文章管理、部署
├── package.json                # pnpm scripts 和依赖
├── astro.config.mjs            # Astro、Markdown、部署 adapter 配置
├── twilight.config.yaml        # 站点标题、导航、侧边栏、主题、壁纸等配置
├── src/content.config.ts       # Astro Content Collections schema
├── scripts/
│   ├── new-post.js             # make article / make draft 调用的建文脚本
│   └── build-with-pagefind.cjs # 构建站点并生成 Pagefind 搜索索引
├── src/
│   ├── content/
│   │   ├── posts/              # 所有文章 Markdown，主要写作目录
│   │   ├── about.md            # 关于页面内容
│   │   ├── projects/           # 项目展示数据
│   │   ├── skills/             # 技能卡片数据
│   │   ├── friends/            # 友链数据
│   │   ├── albums/             # 相册数据
│   │   ├── diary/              # 日记数据
│   │   └── timeline/           # 时间线数据
│   ├── components/             # Astro / Svelte 组件
│   ├── pages/                  # 页面路由
│   ├── plugins/                # remark / rehype / 搜索等插件
│   ├── styles/                 # 全局样式和 Markdown 样式
│   └── utils/                  # 内容、URL、日期、主题等工具函数
├── public/assets/              # 图片、音乐、favicon 等静态资源
└── References/PDE.pdf          # PDE 学习参考资料
```

## 快速开始

首次进入仓库后安装依赖：

```bash
make setup
```

日常开发：

```bash
make dev
```

生产构建：

```bash
make build
```

预览构建产物：

```bash
make preview
```

如果不使用 `make`，对应的 pnpm 命令是：

```bash
pnpm install
pnpm dev
pnpm build
pnpm preview
```

## Makefile 使用说明

`Makefile` 是这个仓库的主要操作入口。所有命令都应在仓库根目录执行。

基本写法：

```bash
make <target> VAR="value"
```

常用变量：

| 变量 | 用途 | 示例 |
| --- | --- | --- |
| `TITLE` | 新文章文件名或标题参数 | `TITLE="pde-energy-methods"` |
| `FILE` | 相对 `src/content/posts/` 的文章路径 | `FILE=pde-introduction-research-map.md` |
| `NEWNAME` | 重命名后的文章路径 | `NEWNAME=pde/energy-methods.md` |
| `DATE` | 日期，建议 `YYYY-MM-DD` | `DATE=2026-05-09` |
| `CATEGORY` | 文章分类 | `CATEGORY=Mathematics` |
| `TAG` | 单个标签 | `TAG=PDE` |
| `MSG` | Git 提交信息 | `MSG="Update README"` |

### 帮助与初始化

| 命令 | 作用 |
| --- | --- |
| `make help` | 打印 Makefile 中的主要命令 |
| `make guide` | 打印模板使用引导 |
| `make setup` | 安装依赖，并提示下一步配置 |
| `make install` | 只执行 `pnpm install` |

### 开发、检查与构建

| 命令 | 实际执行 | 说明 |
| --- | --- | --- |
| `make dev` | `pnpm dev` | 启动 Astro 开发服务器 |
| `make build` | `GITHUB_PAGES=true pnpm build` | 静态构建，输出到 `dist/`，适合 GitHub Pages |
| `make preview` | `pnpm preview` | 预览已构建的站点 |
| `make check` | `pnpm check` 和 `pnpm lint` | 运行 Astro 检查和 Biome 检查；当前 `lint` 会带 `--write` |
| `make format` | `pnpm format` | 格式化 `src/` |
| `make clean` | 删除 `dist`、`.astro`、`node_modules/.astro` | 清理本地构建缓存 |

注意：`make build` 固定设置 `GITHUB_PAGES=true`，验证的是静态构建。如果要测试 Vercel SSR 或 Cloudflare Pages adapter，请直接运行 `pnpm build` 或 `CF_PAGES=1 pnpm build`。

### 创建文章

| 命令 | 作用 |
| --- | --- |
| `make article TITLE="slug"` | 在 `src/content/posts/` 下创建普通文章 |
| `make draft TITLE="slug"` | 创建草稿，并把 `draft` 改成 `true` |
| `make article-with-category TITLE="slug" CATEGORY="Mathematics"` | 创建文章并写入分类 |

建议 `TITLE` 使用英文 slug，不要直接使用长中文标题：

```bash
make article TITLE="pde-energy-methods"
```

生成文件后，再在 frontmatter 中把 `title` 改成正式标题：

```yaml
title: "PDE 能量方法入门"
```

`TITLE` 支持子目录：

```bash
make article TITLE="pde/energy-methods"
```

这会创建：

```text
src/content/posts/pde/energy-methods.md
```

### 查看、检索与统计文章

| 命令 | 作用 |
| --- | --- |
| `make list` | 列出文章标题、文件名、发布日期、草稿状态和 Git 状态 |
| `make info FILE=文章.md` | 查看单篇文章的标题、日期、分类、标签、摘要等 |
| `make search KEYWORD="关键词"` | 在 `src/content/posts/` 中搜索关键词 |
| `make track` | 查看文章总数、Git 变更和最近文章提交记录 |
| `make stats` | 统计总文章数、已发布数和草稿数 |

`FILE` 是相对 `src/content/posts/` 的路径，嵌套文章要带目录：

```bash
make info FILE=guide/index.md
```

### 修改文章状态和元信息

| 命令 | 作用 |
| --- | --- |
| `make publish FILE=文章.md` | 把 `draft: true` 改成 `draft: false` |
| `make publish-all` | 批量发布所有草稿 |
| `make set-date FILE=文章.md DATE=2026-05-09` | 修改 `published` |
| `make set-updated FILE=文章.md` | 把 `updated` 设置为今天 |
| `make set-updated FILE=文章.md DATE=2026-05-09` | 把 `updated` 设置为指定日期 |
| `make set-category FILE=文章.md CATEGORY=Mathematics` | 修改 `category` |
| `make add-tag FILE=文章.md TAG=PDE` | 向 `tags` 追加一个标签 |
| `make encrypt FILE=文章.md` | 设置 `encrypted: true` |
| `make decrypt FILE=文章.md` | 设置 `encrypted: false` |

`make add-tag` 适合快速追加单个标签。复杂标签数组建议手动编辑 frontmatter，保持顺序和命名统一。

加密文章只有同时配置 `encrypted: true` 和 `password` 时才会真正触发密码保护。

### 编辑、重命名、删除和备份

| 命令 | 作用 |
| --- | --- |
| `make edit FILE=文章.md` | 用 `$EDITOR` 打开文章；未设置时默认使用 `code` |
| `make rename FILE=旧名.md NEWNAME=新名.md` | 重命名文章文件 |
| `make delete FILE=文章.md` | 删除文章，执行前会要求确认 |
| `make backup` | 备份整个 `src/content/posts/` 到 `backups/` |

### Git 与部署命令

| 命令 | 作用 |
| --- | --- |
| `make status` | 查看完整 Git 状态 |
| `make log` | 查看最近 10 条提交 |
| `make diff` | 查看未提交 diff |
| `make deploy MSG="提交信息"` | `git add -A`、提交并推送到 `main` |
| `make quick-deploy` | 自动生成提交信息、提交并推送到 `main` |
| `make push MSG="提交信息"` | 提交并推送源码到 `main` |
| `make deploy-only` | 只执行本地静态构建，不推送 |
| `make deploy-vercel` | 使用 Vercel CLI 部署 |
| `make deploy-docker` | 构建 Docker 镜像 |
| `make deploy-podman` | 构建 Podman 镜像 |
| `make deploy-server` | 构建后用 `rsync` 上传到服务器 |
| `make enable-workflow` | 如果存在 workflow 示例，则启用 GitHub Actions workflow |

需要特别注意：

- `make deploy`、`make quick-deploy`、`make push` 都会推送到 `main`。
- 当前 `.github/workflows/deploy.yml` 会在 `main` 分支 push 后自动构建并部署 GitHub Pages。
- `make deploy-vercel` 会在缺少 Vercel CLI 时尝试全局安装 `vercel`。
- `make deploy-server` 需要设置 `DEPLOY_SERVER` 和 `DEPLOY_PATH`。

服务器部署示例：

```bash
DEPLOY_SERVER=user@example.com DEPLOY_PATH=/var/www/blog make deploy-server
```

## 文章写作流程

推荐流程：

1. 创建文章：

   ```bash
   make article TITLE="pde-energy-methods"
   ```

2. 编辑 frontmatter：

   ```yaml
   ---
   title: "PDE 能量方法入门"
   published: 2026-05-09
   updated: 2026-05-09
   description: "从积分分部、能量泛函和唯一性证明理解 PDE 中的能量方法。"
   cover: "/assets/images/cover_math_2.png"
   tags: [PDE, Analysis, Energy Methods]
   category: Mathematics
   draft: false
   lang: zh
   ---
   ```

3. 查看文章元信息：

   ```bash
   make info FILE=pde-energy-methods.md
   ```

4. 本地预览：

   ```bash
   make dev
   ```

5. 构建检查：

   ```bash
   make build
   ```

6. 提交：

   ```bash
   git status
   git add src/content/posts/pde-energy-methods.md
   git commit -m "Add PDE energy methods note"
   git push origin main
   ```

## 文章导览

当前仓库共有 24 篇文章，分布在 4 个分类中：

```text
📊 博客统计信息:

📝 总文章数: 24
✅ 已发布: 24
📝 草稿: 0
```

| 分类 | 数量 | 内容重心 |
| --- | ---: | --- |
| `Mathematics` | 15 | PDE、数学分析、数值方法、PINN、LaTeX |
| `Programming` | 4 | 深度学习和神经网络结构 |
| `Linux` | 3 | Fedora、发行版、桌面环境和显示协议 |
| `Guides` | 2 | 博客模板说明和自定义组件展示 |

### 博客内容整理分类

按实际内容线索，可以把当前博客整理成 6 个阅读与维护分组：

| 内容分组 | 数量 | 对应文章 | 分类与标签维护 |
| --- | ---: | --- | --- |
| PDE 主线与科学机器学习 | 7 | PDE 入门、理论求解、数值方法、数值模拟、学习资源、PINN、fPINN | `category: Mathematics`；核心标签使用 `PDE`、`Numerical Analysis`、`PINN`、`Scientific Machine Learning` |
| Evans PDE 教材精读 | 4 | Evans 前言目录、Chapter 1、Chapter 2、Chapter 3 | `category: Mathematics`；统一使用 `PDE`、`Evans`、`Study Notes`，章节翻译再加 `Translation` |
| 数学基础与 LaTeX | 4 | 实分析三性原理、抽屉原理、拓扑入门、LaTeX 高级功能 | `category: Mathematics`；按主题补充 `Real Analysis`、`Set Theory`、`Topology`、`LaTeX` |
| 深度学习与神经网络 | 4 | 正则化、CNN、RNN、Transformer | `category: Programming`；统一使用 `Deep Learning`，再补充模型标签 |
| Linux 系统与桌面 | 3 | Linux 发行版、Fedora / DNF、桌面环境与显示协议 | `category: Linux`；统一使用 `Linux`，再补充发行版、工具或协议标签 |
| 博客模板与组件 | 2 | 博客模板指南、自定义组件展示 | `category: Guides`；使用 `Markdown`、`LaTeX`、`Mermaid`、`Components`、`UI` 等功能标签 |

后续新增文章时，优先先判断它属于上面哪一组，再决定 `category` 和 `tags`。如果一篇文章连接多个方向，例如 PDE 与深度学习交叉，`category` 仍保持一个主类，交叉关系用标签表达。

下面的链接指向仓库中的 Markdown 源文件。站点访问路径通常是 `/posts/<slug>/`。

### PDE 主线

这条路线是当前博客的核心内容，适合按“认识问题 - 理论方法 - 数值方法 - 可重复模拟 - 学习资源 - 神经网络方法”的顺序阅读。

| 顺序 | 文章 | 引导说明 |
| ---: | --- | --- |
| 1 | [PDE 入门：从方程、模型到研究地图](src/content/posts/pde-introduction-research-map.md) | 建立 PDE 的基本对象、定解问题、分类和研究版图。 |
| 2 | [PDE 理论求解：经典方法、弱解与能量估计](src/content/posts/pde-theoretical-methods-guide.md) | 进入特征线、Fourier 方法、Green 函数、弱解和能量估计。 |
| 3 | [PDE 数值求解入门：差分、有限元、有限体积与谱方法](src/content/posts/pde-numerical-methods-introduction.md) | 对比主流离散方法，理解数值 PDE 的基本框架。 |
| 4 | [PDE 数值模拟：从模型到可重复实验](src/content/posts/pde-numerical-simulation-workflow.md) | 从建模、无量纲化、网格、时间步进到验证和可视化。 |
| 5 | [PDE 学习资源推荐：国内外教材、课程与路线](src/content/posts/pde-learning-resources-textbooks.md) | 汇总教材、课程、软件和后续学习路线。 |
| 6 | [数学视角下的 PINN：用物理约束训练神经网络](src/content/posts/pinn-math-physics-informed-neural-networks.md) | 把 PDE 约束、自动微分和优化问题连接到神经网络训练。 |
| 7 | [fPINN：分数阶物理信息神经网络的数学与实现](src/content/posts/fpinn-fractional-physics-informed-neural-networks.md) | 进一步讨论分数阶微积分、非局部算子和 fPINN 训练难点。 |

### Evans PDE 精读

Evans 系列用于教材精读、目录整理和章节译注，参考资料在 [References/PDE.pdf](References/PDE.pdf)。

| 顺序 | 文章 | 引导说明 |
| ---: | --- | --- |
| 1 | [Evans《偏微分方程》第二版：前言、书目信息与目录中译](src/content/posts/evans-pde-frontmatter-zh.md) | 先看书目信息、前言和目录，了解全书结构。 |
| 2 | [Chapter 1：Introduction 中译与学习注释](src/content/posts/evans-pde-chapter-1-introduction-zh.md) | 梳理第一章的引言、基本例子和学习注释。 |
| 3 | [Chapter 2：四类重要线性 PDE 中译与学习注释](src/content/posts/evans-pde-chapter-2-four-important-linear-pdes-zh.md) | 进入输运方程、Laplace 方程、热方程和波方程。 |
| 4 | [Chapter 3：非线性一阶 PDE 学习整理](src/content/posts/evans-pde-chapter-3-nonlinear-first-order-pdes-zh.md) | 梳理完整积分、包络、特征线、Hamilton-Jacobi 方程和守恒律。 |

后续新增 Evans 章节时，建议继续使用同一文件命名和标签组合：

```text
evans-pde-chapter-<n>-<topic>-zh.md
tags: [PDE, Evans, Study Notes]
category: Mathematics
```

如果是章节中译或译注稿，再补充 `Translation`；如果是内容整理或专题讲解，则使用 `Nonlinear PDE`、`First-Order PDE` 等主题标签。

### 数学基础与排版工具

这些文章可以作为 PDE 和机器学习内容的基础补充。

| 文章 | 引导说明 |
| --- | --- |
| [实分析的三性原理](src/content/posts/real-analysis-principles.md) | 适合补充测度论、收敛和近似思想。 |
| [集合论中的抽屉原理](src/content/posts/pigeonhole-principle.md) | 适合补充集合论和组合思想。 |
| [数学拓扑学入门介绍](src/content/posts/topology-intro.md) | 从开集和连续映射建立拓扑学直觉。 |
| [LaTeX 高级功能详解](src/content/posts/latex-advanced.md) | 记录公式、表格、自定义宏和专业排版技巧。 |

### 深度学习与神经网络

这条路线面向神经网络结构和训练方法。阅读顺序可以从训练稳定性开始，再看具体结构。

| 顺序 | 文章 | 引导说明 |
| ---: | --- | --- |
| 1 | [正则化与深度学习](src/content/posts/regularization-deep-learning.md) | 理解 L1/L2、Dropout、Batch Normalization 等训练约束。 |
| 2 | [卷积神经网络 (CNN) 完全指南](src/content/posts/cnn-guide.md) | 从卷积运算、特征图到经典 CNN 架构。 |
| 3 | [循环神经网络 (RNN) 深度解析](src/content/posts/rnn-guide.md) | 理解序列建模、梯度问题、LSTM 和 GRU。 |
| 4 | [Transformer 与注意力机制详解](src/content/posts/transformer-attention.md) | 从 Self-Attention 到 GPT / BERT 架构。 |
| 5 | [数学视角下的 PINN](src/content/posts/pinn-math-physics-informed-neural-networks.md) | 作为深度学习与 PDE 的交叉入口。 |

### Linux 与桌面系统

这部分适合按“系统选择 - 包管理 - 桌面协议”的方式阅读。

| 顺序 | 文章 | 引导说明 |
| ---: | --- | --- |
| 1 | [Linux 发行版详细介绍](src/content/posts/linux-distributions.md) | 对比 Fedora、Ubuntu、Arch、Debian 等发行版。 |
| 2 | [Fedora 系统与 DNF 包管理器完全指南](src/content/posts/fedora-dnf-guide.md) | 聚焦 Fedora 和 DNF 的日常使用。 |
| 3 | [Linux 桌面系统与显示协议总结](src/content/posts/linux-desktop-protocols.md) | 说明桌面环境、窗口管理器、X11 和 Wayland。 |

### 博客模板与组件

这部分用于维护站点能力说明和组件展示。

| 文章 | 状态 | 引导说明 |
| --- | --- | --- |
| [博客模板指南](src/content/posts/guide/index.md) | `encrypted: true` | 模板使用说明，包含 LaTeX、Mermaid、视频嵌入等演示。 |
| [博客自定义组件展示](src/content/posts/components-showcase.md) | `pinned: true` | 展示渐变标题、卡片轮播、阅读进度和动态图表。 |

## 分类与标签整理

### 分类规则

`category` 是文章的大类，一篇文章只设置一个。当前建议保持这四类：

| 分类 | 使用范围 | 不建议放入 |
| --- | --- | --- |
| `Mathematics` | PDE、数学分析、数值方法、PINN、LaTeX 数学排版 | 纯工程配置、系统教程 |
| `Programming` | 深度学习、神经网络、编程方法和模型结构 | Linux 系统管理 |
| `Linux` | 发行版、包管理器、桌面环境、显示协议 | 通用编程文章 |
| `Guides` | 博客模板、组件展示、站点使用说明 | 普通技术笔记 |

如果新增方向，优先先用现有分类承接。只有当一个方向会持续产生多篇文章时，再新增分类。

### 高频标签

当前高频标签如下：

| 标签 | 数量 | 建议用途 |
| --- | ---: | --- |
| `PDE` | 10 | 偏微分方程主标签 |
| `Mathematics` | 5 | 数学基础或跨数学主题文章 |
| `Deep Learning` | 5 | 深度学习总标签 |
| `Neural Networks` | 4 | 神经网络结构与训练 |
| `Evans` | 4 | Evans PDE 教材系列 |
| `Linux` | 3 | Linux 相关文章 |
| `Study Notes` | 3 | 学习注释和读书笔记 |
| `Translation` | 3 | 翻译、译注、章节整理 |
| `LaTeX` | 2 | LaTeX 与排版 |
| `NLP` | 2 | 自然语言处理相关内容 |
| `Numerical Analysis` | 2 | 数值分析与 PDE 数值方法 |
| `PINN` | 2 | Physics-Informed Neural Networks |

### 标签层级

建议按下面顺序排列标签：

```yaml
tags: [领域, 系列或对象, 方法或专题, 内容类型]
```

示例：

```yaml
tags: [PDE, Evans, Translation, Study Notes]
tags: [PDE, Numerical Analysis, FEM, FVM, Finite Difference]
tags: [PINN, Scientific Machine Learning, PDE, Deep Learning]
tags: [Deep Learning, Transformer, Attention, NLP, Neural Networks]
tags: [Linux, Fedora, DNF, Package Manager]
```

### 标签命名约定

- 使用英文标签，首字母大写或保留通用缩写，例如 `PDE`、`PINN`、`CNN`、`RNN`。
- 同一概念只保留一种写法：统一用 `PDE`，不要混用 `Partial Differential Equations`。
- 深度学习总标签统一用 `Deep Learning`，不要混用 `DL`。
- 数值 PDE 文章优先使用 `PDE` 和 `Numerical Analysis`，再补充 `FEM`、`FVM`、`Finite Difference`、`CFD` 等具体方法。
- Evans 系列统一包含 `PDE`、`Evans` 和 `Translation`。章节译注再加 `Study Notes`，书目信息可用 `Textbook`。
- Linux 文章优先使用 `Linux`，再补充发行版、工具或协议标签，例如 `Fedora`、`DNF`、`Wayland`、`X11`。
- 博客模板和组件文章使用 `Guides` 作为分类，标签使用 `Markdown`、`LaTeX`、`Mermaid`、`Components`、`UI`、`Design` 等功能词。

## Frontmatter 规范

文章 schema 定义在 [src/content.config.ts](src/content.config.ts)。推荐字段如下：

| 字段 | 必填 | 说明 |
| --- | --- | --- |
| `title` | 是 | 文章标题，显示在列表、详情页和 SEO 信息中 |
| `published` | 是 | 发布时间，使用 `YYYY-MM-DD` |
| `updated` | 否 | 更新时间，改动较大时补充 |
| `description` | 否 | 摘要，用于文章卡片、搜索和 SEO |
| `cover` | 否 | 封面路径，通常放在 `public/assets/images/` |
| `tags` | 否 | 标签数组，建议使用英文标签 |
| `category` | 否 | 单一分类，优先使用当前四类 |
| `draft` | 否 | `true` 表示草稿；生产环境不展示 |
| `lang` | 否 | 内容语言，例如 `zh`、`en` |
| `pinned` | 否 | 是否置顶 |
| `sourceLink` | 否 | 原书、论文、项目或资料来源链接 |
| `encrypted` | 否 | 是否启用文章加密 |
| `password` | 否 | 加密文章密码；需配合 `encrypted: true` |
| `routeName` | 否 | 自定义文章路由 |

推荐模板：

```yaml
---
title: "文章标题"
published: 2026-05-09
updated: 2026-05-09
description: "一句话说明这篇文章解决什么问题。"
cover: "/assets/images/cover_math_1.png"
tags: [PDE, Analysis]
category: Mathematics
draft: false
lang: zh
---
```

## 部署说明

### GitHub Pages

当前仓库包含 `.github/workflows/deploy.yml`。推送到 `main` 后，GitHub Actions 会安装依赖、执行 `pnpm build`，并设置：

```text
GITHUB_PAGES=true
```

本地等价检查：

```bash
make build
```

### Vercel

默认 `astro.config.mjs` 在没有 `GITHUB_PAGES=true`、没有 `CF_PAGES=1` 时使用 Vercel adapter。

本地检查：

```bash
pnpm build
```

CLI 部署：

```bash
make deploy-vercel
```

### Cloudflare Pages

Cloudflare Pages 会自动注入 `CF_PAGES=1`，项目会使用 `@astrojs/cloudflare` adapter。

本地检查：

```bash
CF_PAGES=1 pnpm build
```

### Docker、Podman 和服务器

```bash
make deploy-docker
make deploy-podman
DEPLOY_SERVER=user@example.com DEPLOY_PATH=/var/www/blog make deploy-server
```

## 维护检查表

新增或整理文章时，建议按下面顺序检查：

- 文件名是否使用稳定英文 slug。
- `title` 是否是正式标题，而不是文件名。
- `description` 是否能说明文章的核心内容。
- `category` 是否属于当前四类之一。
- `tags` 是否遵循“领域 - 系列或对象 - 方法或专题 - 内容类型”的顺序。
- PDE、Evans、PINN、Deep Learning、Linux 等高频标签是否使用了统一写法。
- 草稿是否设置为 `draft: true`，准备发布时再执行 `make publish FILE=...`。
- 加密文章是否同时设置了 `encrypted: true` 和 `password`。
- 发布前是否执行过 `make info FILE=...` 和 `make build`。
- 推送前是否确认 `git status` 中只有预期变更。

## 致谢与许可

本项目基于 Twilight / astro-theme-retypeset 相关设计和 Astro 生态构建。

许可证见 [LICENSE](LICENSE)。

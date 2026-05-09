# Goblinunde Blog

这是 `goblinunde.github.io` 的博客源码仓库，基于 Astro / Svelte / Twilight-retypeset 维护。站点主要用于整理数学、PDE、科学机器学习、深度学习、Linux 和博客模板相关内容。

站点地址：<https://goblinunde.github.io/>

## 目录

- [项目结构](#项目结构)
- [快速开始](#快速开始)
- [Makefile 使用说明](#makefile-使用说明)
- [文章写作流程](#文章写作流程)
- [文章导览](#文章导览)
- [分类与标签规范](#分类与标签规范)
- [常用文件](#常用文件)
- [项目配置修改](#项目配置修改)
- [部署说明](#部署说明)

## 项目结构

```text
.
├── Makefile                       # 本地开发、文章管理、部署的主要入口
├── package.json                   # pnpm scripts 与依赖
├── twilight.config.yaml           # 站点配置、导航、侧边栏、播放器等
├── public/                        # 静态资源
│   └── assets/
│       ├── images/                # 头像、壁纸、文章封面
│       └── music/                 # 本地音乐资源
├── References/
│   └── PDE.pdf                    # Evans PDE 参考书 PDF
└── src/
    ├── content/
    │   ├── posts/                 # 文章 Markdown，主要写作目录
    │   ├── about.md               # 关于页面内容
    │   ├── friends/               # 友链数据
    │   ├── projects/              # 项目展示数据
    │   ├── skills/                # 技能卡片数据
    │   ├── albums/                # 相册数据
    │   ├── diary/                 # 日记/动态数据
    │   └── timeline/              # 时间线数据
    ├── components/                # 页面与交互组件
    ├── pages/                     # Astro 路由
    ├── styles/                    # 全局样式与 Markdown 样式
    ├── plugins/                   # remark / rehype / 搜索等插件
    └── utils/                     # 工具函数
```

## 快速开始

首次安装依赖：

```bash
make setup
```

日常开发：

```bash
make dev
```

构建生产版本：

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

`Makefile` 是这个仓库的主要操作入口。所有命令都在仓库根目录执行。

### 查看帮助

| 命令 | 用途 |
| --- | --- |
| `make help` | 查看全部常用命令 |
| `make guide` | 查看项目内置用户引导 |
| `make setup` | 安装依赖并输出首次设置提示 |

### 开发与检查

| 命令 | 用途 |
| --- | --- |
| `make install` | 执行 `pnpm install` |
| `make dev` | 启动 Astro 开发服务器 |
| `make build` | 执行生产构建，输出到 `dist/` |
| `make preview` | 本地预览构建结果 |
| `make check` | 执行 `pnpm check` 和 `pnpm lint` |
| `make format` | 执行 `pnpm format` |
| `make clean` | 删除 `dist`、`.astro`、`node_modules/.astro` |

### 文章创建

| 命令 | 用途 |
| --- | --- |
| `make article TITLE="文章标题"` | 在 `src/content/posts/` 下创建新文章 |
| `make draft TITLE="草稿标题"` | 创建草稿，并设置 `draft: true` |
| `make article-with-category TITLE="标题" CATEGORY="Mathematics"` | 创建文章并写入分类 |

注意：`TITLE` 会直接作为文件名生成 `src/content/posts/<TITLE>.md`。更适合长期维护的方式是使用英文 slug，例如：

```bash
make article TITLE="pde-energy-methods"
```

然后在 frontmatter 里把 `title` 改成正式中文标题。

### 文章查看与检索

| 命令 | 用途 |
| --- | --- |
| `make list` | 列出所有文章、发布时间、草稿状态和 Git 状态 |
| `make info FILE=文章.md` | 查看单篇文章的标题、日期、分类、标签、摘要等 |
| `make search KEYWORD="关键词"` | 在文章中搜索关键词 |
| `make track` | 查看文章总数、Git 变更和最近文章提交记录 |
| `make stats` | 查看文章总数、已发布数和草稿数 |

`FILE` 是相对 `src/content/posts/` 的路径。嵌套文章也可以写成：

```bash
make info FILE=guide/index.md
```

### 文章维护

| 命令 | 用途 |
| --- | --- |
| `make publish FILE=文章.md` | 把草稿改为发布状态 |
| `make publish-all` | 批量发布所有草稿 |
| `make edit FILE=文章.md` | 用 `$EDITOR` 打开文章，默认使用 `code` |
| `make rename FILE=旧名.md NEWNAME=新名.md` | 重命名文章文件 |
| `make delete FILE=文章.md` | 删除文章，会要求确认 |
| `make backup` | 备份 `src/content/posts/` 到 `backups/` |

### 日期、分类、标签

| 命令 | 用途 |
| --- | --- |
| `make set-date FILE=文章.md DATE=2026-05-09` | 修改发布时间 `published` |
| `make set-updated FILE=文章.md` | 设置 `updated` 为当天日期 |
| `make set-updated FILE=文章.md DATE=2026-05-09` | 设置指定更新时间 |
| `make set-category FILE=文章.md CATEGORY=Mathematics` | 修改文章分类 |
| `make add-tag FILE=文章.md TAG=PDE` | 给文章添加标签 |

建议：复杂标签数组最好直接手动编辑 frontmatter，`make add-tag` 适合快速追加单个标签。

### 加密文章

| 命令 | 用途 |
| --- | --- |
| `make encrypt FILE=文章.md` | 设置 `encrypted: true` |
| `make decrypt FILE=文章.md` | 设置 `encrypted: false` |

加密文章还需要在 frontmatter 中配置密码字段，具体以站点加密组件实现为准。

### Git 与部署

| 命令 | 用途 |
| --- | --- |
| `make status` | 查看 Git 状态 |
| `make log` | 查看最近 10 条提交 |
| `make diff` | 查看未提交 diff |
| `make deploy MSG="提交信息"` | `git add -A`、提交并推送到 `main` |
| `make quick-deploy` | 自动生成提交信息并推送 |
| `make push MSG="提交信息"` | 提交并推送源码 |
| `make deploy-only` | 只本地构建，不推送 |
| `make deploy-vercel` | 使用 Vercel CLI 部署 |
| `make deploy-docker` | 构建 Docker 镜像 |
| `make deploy-podman` | 构建 Podman 镜像 |
| `make deploy-server` | 构建并用 rsync 上传到服务器 |
| `make enable-workflow` | 启用 GitHub Actions workflow 示例 |

注意：`make deploy`、`make quick-deploy`、`make push` 都会把变更推送到 `main`。如果 GitHub Actions 监听 `main`，推送会触发自动构建/部署。

## 文章写作流程

推荐写作流程：

1. 创建文章文件：

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

3. 本地预览：

   ```bash
   make dev
   ```

4. 构建检查：

   ```bash
   make build
   ```

5. 提交与推送：

   ```bash
   git add src/content/posts/pde-energy-methods.md
   git commit -m "Add PDE energy methods note"
   git push origin main
   ```

### Frontmatter 字段

| 字段 | 必填 | 说明 |
| --- | --- | --- |
| `title` | 是 | 文章标题，会显示在列表与详情页 |
| `published` | 是 | 发布时间，建议使用 `YYYY-MM-DD` |
| `updated` | 否 | 更新时间 |
| `description` | 否 | 摘要，用于文章卡片、SEO 和检索 |
| `cover` | 否 | 封面图路径，通常放在 `public/assets/images/` |
| `tags` | 否 | 标签数组，建议使用英文标签 |
| `category` | 否 | 单一分类 |
| `draft` | 否 | `true` 表示草稿 |
| `lang` | 否 | 语言，例如 `zh`、`en` |
| `pinned` | 否 | 是否置顶 |
| `sourceLink` | 否 | 原书、论文、项目或资料来源链接 |
| `encrypted` | 否 | 是否启用文章加密 |

## 文章导览

当前文章主要分成四条阅读路线。

### 1. PDE 与数学分析

这是当前最核心的内容方向，适合按“入门总览 -> 理论方法 -> 数值方法 -> 专题/教材整理”的顺序阅读。

| 推荐顺序 | 文章 |
| --- | --- |
| 1 | [PDE 入门：从方程、模型到研究地图](src/content/posts/pde-introduction-research-map.md) |
| 2 | [PDE 理论求解：经典方法、弱解与能量估计](src/content/posts/pde-theoretical-methods-guide.md) |
| 3 | [PDE 数值求解入门：差分、有限元、有限体积与谱方法](src/content/posts/pde-numerical-methods-introduction.md) |
| 4 | [PDE 数值模拟：从模型到可重复实验](src/content/posts/pde-numerical-simulation-workflow.md) |
| 5 | [PDE 学习资源推荐：国内外教材、课程与路线](src/content/posts/pde-learning-resources-textbooks.md) |
| 6 | [数学视角下的 PINN：用物理约束训练神经网络](src/content/posts/pinn-math-physics-informed-neural-networks.md) |
| 7 | [fPINN：分数阶物理信息神经网络的数学与实现](src/content/posts/fpinn-fractional-physics-informed-neural-networks.md) |

Evans《Partial Differential Equations》系列用于精读和章节整理：

| 顺序 | 文章 |
| --- | --- |
| 1 | [Evans《偏微分方程》第二版：前言、书目信息与目录中译](src/content/posts/evans-pde-frontmatter-zh.md) |
| 2 | [Chapter 1：Introduction 中译与学习注释](src/content/posts/evans-pde-chapter-1-introduction-zh.md) |
| 3 | [Chapter 2：四类重要线性 PDE 中译与学习注释](src/content/posts/evans-pde-chapter-2-four-important-linear-pdes-zh.md) |

相关数学基础：

- [实分析的三性原理](src/content/posts/real-analysis-principles.md)
- [集合论中的抽屉原理](src/content/posts/pigeonhole-principle.md)
- [数学拓扑学入门介绍](src/content/posts/topology-intro.md)
- [LaTeX 高级功能详解](src/content/posts/latex-advanced.md)

### 2. 深度学习与神经网络

这部分面向机器学习基础和网络结构理解。

| 推荐顺序 | 文章 |
| --- | --- |
| 1 | [正则化与深度学习](src/content/posts/regularization-deep-learning.md) |
| 2 | [卷积神经网络 (CNN) 完全指南](src/content/posts/cnn-guide.md) |
| 3 | [循环神经网络 (RNN) 深度解析](src/content/posts/rnn-guide.md) |
| 4 | [Transformer 与注意力机制详解](src/content/posts/transformer-attention.md) |

### 3. Linux 与桌面系统

这部分整理 Linux 发行版、Fedora/DNF 和显示协议。

| 推荐顺序 | 文章 |
| --- | --- |
| 1 | [Fedora 系统与 DNF 包管理器完全指南](src/content/posts/fedora-dnf-guide.md) |
| 2 | [Linux 发行版详细介绍](src/content/posts/linux-distributions.md) |
| 3 | [Linux 桌面系统与显示协议总结](src/content/posts/linux-desktop-protocols.md) |

### 4. 博客使用与组件展示

这部分用于记录站点能力、Markdown 语法和自定义组件。

- [博客模板指南](src/content/posts/guide/index.md)
- [博客自定义组件展示](src/content/posts/components-showcase.md)

## 分类与标签规范

### 当前分类

| 分类 | 当前数量 | 使用场景 |
| --- | ---: | --- |
| `Mathematics` | 14 | PDE、数学分析、数值方法、PINN、LaTeX 等 |
| `Programming` | 4 | 深度学习、模型结构、编程相关内容 |
| `Linux` | 3 | Linux 发行版、Fedora、桌面环境和协议 |
| `Guides` | 2 | 博客模板、组件展示、使用说明 |

分类应保持少而稳定。一篇文章只设置一个 `category`，优先选择上面四类。

### 高频标签

| 标签 | 当前数量 | 建议用途 |
| --- | ---: | --- |
| `PDE` | 9 | 偏微分方程总标签 |
| `Mathematics` | 5 | 数学基础或跨数学主题文章 |
| `Deep Learning` | 5 | 深度学习与神经网络文章 |
| `Neural Networks` | 4 | 神经网络结构与训练 |
| `Evans` | 3 | Evans PDE 读书系列 |
| `Linux` | 3 | Linux 相关文章 |
| `Translation` | 3 | 翻译、译注、章节整理 |
| `LaTeX` | 2 | LaTeX 与排版 |
| `Numerical Analysis` | 2 | 数值分析与 PDE 数值方法 |
| `PINN` | 2 | Physics-Informed Neural Networks |
| `Study Notes` | 2 | 学习注释与读书笔记 |

### 标签写法建议

标签建议使用英文，并遵循以下层次：

```yaml
tags: [领域, 系列或对象, 方法或专题]
```

例子：

```yaml
tags: [PDE, Evans, Translation, Study Notes]
tags: [PDE, Numerical Analysis, FEM, FVM]
tags: [PINN, Scientific Machine Learning, PDE, Deep Learning]
tags: [Linux, Fedora, DNF, Package Manager]
tags: [Deep Learning, Transformer, Attention, NLP]
```

维护规则：

- `category` 用大类，`tags` 用细分主题。
- 同一概念尽量只保留一种写法，例如统一用 `PDE`，不要混用 `Partial Differential Equations`。
- 系列文章应有稳定标签，例如 Evans 系列统一包含 `[PDE, Evans, Translation, Study Notes]`。
- 数值 PDE 文章优先使用 `PDE`、`Numerical Analysis`，再补充 `FEM`、`FVM`、`Finite Difference`、`CFD` 等具体方法。
- 深度学习文章优先使用 `Deep Learning`，再补充 `CNN`、`RNN`、`Transformer`、`Attention`、`NLP` 等模型标签。
- Linux 文章优先使用 `Linux`，再补充发行版、工具或协议标签，例如 `Fedora`、`DNF`、`Wayland`、`X11`。

## 常用文件

| 文件 | 用途 |
| --- | --- |
| `src/content/posts/` | 所有文章的 Markdown 源文件 |
| `src/content/about.md` | 关于页面 |
| `twilight.config.yaml` | 站点标题、导航、侧边栏、主题、壁纸、音乐等配置 |
| `public/assets/images/` | 头像、封面、壁纸等图片 |
| `src/styles/extension.css` | 推荐放自定义样式 |
| `src/styles/markdown.css` | Markdown 正文样式 |
| `src/content.config.ts` | Astro Content Collections schema |
| `scripts/new-post.js` | 创建文章的脚本，供 `make article` 调用 |

## 项目配置修改

部署前优先检查三个配置文件：`twilight.config.yaml`、`astro.config.mjs`、`vercel.json`。

### 站点基础配置

主要改 `twilight.config.yaml`：

```yaml
site:
  siteURL: "https://goblinunde.github.io/"
  title: "Goblinunde"
  subtitle: "数学与计算机爱好者"
  lang: "zh"
```

修改建议：

- `site.siteURL` 必须改成最终访问域名，并以 `/` 结尾。
- 部署到 Vercel 默认域名时，可临时写成 `https://<project>.vercel.app/`。
- 部署到 Cloudflare Pages 默认域名时，可临时写成 `https://<project>.pages.dev/`。
- 使用自定义域名时，统一写成最终域名，例如 `https://blog.example.com/`。
- `title`、`subtitle` 会影响站点标题、首页展示和部分 SEO 信息。
- `navbar`、`profile`、`post`、`musicPlayer` 等也都在 `twilight.config.yaml` 中维护。

### Astro 部署适配器

当前 `astro.config.mjs` 已经支持三种构建模式：

```js
const isGitHubPages = process.env.GITHUB_PAGES === "true";
const adapter = process.env.CF_PAGES
    ? cloudflarePages({ imageService: "compile" })
    : vercel({ mode: "serverless" });

export default defineConfig({
    site: siteConfig.siteURL,
    base: "/",
    trailingSlash: "always",
    output: isGitHubPages ? "static" : "server",
    adapter: isGitHubPages ? undefined : adapter,
});
```

含义：

- `GITHUB_PAGES=true`：静态构建，不使用 SSR adapter，适合 GitHub Pages。
- `CF_PAGES=1`：使用 `@astrojs/cloudflare`，适合 Cloudflare Pages / Pages Functions。
- 默认情况：使用 `@astrojs/vercel`，适合 Vercel Serverless SSR。

Cloudflare 分支中使用 `imageService: "compile"`，目的是在构建阶段处理可预渲染页面中的图片，避免 Cloudflare runtime 不支持 sharp 时出现图片优化问题。

本地按平台测试：

```bash
# Vercel 模式，默认 SSR adapter
pnpm build

# Cloudflare Pages 模式
CF_PAGES=1 pnpm build

# GitHub Pages 静态模式
GITHUB_PAGES=true pnpm build
```

注意：`make build` 当前会设置 `GITHUB_PAGES=true`，因此它验证的是静态构建。如果要验证 Vercel 或 Cloudflare adapter，请直接使用上面的 `pnpm build` 命令。

### Pagefind 输出目录

`scripts/build-with-pagefind.cjs` 会根据环境变量选择搜索索引输出目录：

| 平台 | 识别条件 | Pagefind 目录 |
| --- | --- | --- |
| Vercel | `VERCEL` 或本地存在 `.vercel/` | `.vercel/output/static` |
| Cloudflare Pages | `CF_PAGES` | `dist` |
| GitHub Actions / 默认 | `GITHUB_ACTIONS` 或无平台变量 | `dist` |

如果本地已经存在 `.vercel/`，`pnpm build` 可能会被识别为 Vercel 模式。要测试 Cloudflare，请显式运行：

```bash
CF_PAGES=1 pnpm build
```

### Vercel 配置文件

`vercel.json` 当前配置了：

- `buildCommand`: `pnpm build`
- `installCommand`: `pnpm install`
- `framework`: `astro`
- 通用安全响应头
- `_astro`、`assets`、`favicon`、`pio` 等静态资源缓存头
- `cleanUrls: true`

一般不需要改 `vercel.json`。如果切换域名，优先改 `twilight.config.yaml` 的 `site.siteURL`，域名绑定在 Vercel Dashboard 中完成。

## 部署说明

本仓库可以部署到 Vercel、Cloudflare Pages、GitHub Pages 或自有服务器。当前项目更适合优先使用 Vercel 或 Cloudflare Pages。

### 部署到 Vercel

适用场景：希望使用 Vercel 的 Astro SSR、预览部署、自动 Git 集成和 Serverless Functions。

#### 1. 准备配置

确认 `twilight.config.yaml`：

```yaml
site:
  siteURL: "https://<your-project>.vercel.app/"
```

如果已经绑定自定义域名，写自定义域名：

```yaml
site:
  siteURL: "https://blog.example.com/"
```

确认 `astro.config.mjs` 中默认 adapter 是 Vercel：

```js
const adapter = process.env.CF_PAGES
    ? cloudflarePages({ imageService: "compile" })
    : vercel({ mode: "serverless" });
```

不要在 Vercel 项目环境变量中设置 `GITHUB_PAGES=true` 或 `CF_PAGES=1`。

#### 2. Vercel Dashboard 部署

在 Vercel 中导入 GitHub 仓库：

| 配置项 | 推荐值 |
| --- | --- |
| Framework Preset | `Astro` |
| Root Directory | 留空，使用仓库根目录 |
| Install Command | `pnpm install` |
| Build Command | `pnpm build` |
| Output Directory | 使用默认值；如面板要求填写，保留 `dist` 即可 |

部署后，Vercel 会在每次推送到 `main` 时自动构建。Pull Request 会生成 Preview URL。

#### 3. Vercel CLI 部署

也可以使用本仓库的 Makefile：

```bash
make deploy-vercel
```

或直接使用 Vercel CLI：

```bash
npm i -g vercel
vercel
vercel --prod
```

#### 4. Vercel 部署检查

本地检查：

```bash
pnpm build
```

如果构建日志显示 Pagefind 输出到 `.vercel/output/static`，说明构建脚本按 Vercel 模式处理搜索索引。

### 部署到 Cloudflare Pages

适用场景：希望使用 Cloudflare CDN、Pages 预览部署、Pages Functions，并让 `@astrojs/cloudflare` adapter 处理 SSR。

#### 1. 准备配置

确认 `twilight.config.yaml`：

```yaml
site:
  siteURL: "https://<your-project>.pages.dev/"
```

如果已经绑定自定义域名：

```yaml
site:
  siteURL: "https://blog.example.com/"
```

当前 `astro.config.mjs` 会在 Cloudflare Pages 环境中自动选择 Cloudflare adapter，因为 Cloudflare Pages 默认注入 `CF_PAGES=1`：

```js
const adapter = process.env.CF_PAGES
    ? cloudflarePages({ imageService: "compile" })
    : vercel({ mode: "serverless" });
```

不要在 Cloudflare Pages 中设置 `GITHUB_PAGES=true`，否则会强制走静态构建。

#### 2. Cloudflare Dashboard 部署

在 Cloudflare Dashboard 中：

1. 进入 `Workers & Pages`。
2. 选择 `Create application`。
3. 选择 `Pages`。
4. 选择 `Import an existing Git repository`。
5. 选择该 GitHub 仓库。
6. 使用下面配置：

| 配置项 | 推荐值 |
| --- | --- |
| Production branch | `main` |
| Framework preset | `Astro` |
| Build command | `pnpm build` |
| Build output directory | `dist` |
| Root directory | 留空，使用仓库根目录 |

建议在 Cloudflare Pages 的环境变量中设置：

| 环境变量 | 建议值 | 说明 |
| --- | --- | --- |
| `NODE_VERSION` | `22` 或 `20` | 固定 Node 版本，避免构建镜像默认版本变化 |
| `PNPM_VERSION` | `9.14.4` | 与 `packageManager` 保持一致 |

Cloudflare Pages 会自动提供 `CF_PAGES=1`，不需要手动添加。

#### 3. Cloudflare KV / Sessions

Cloudflare adapter 构建时可能出现类似提示：

```text
Enabling sessions with Cloudflare KV with the "SESSION" KV binding.
If you see the error "Invalid binding `SESSION`" in your build output,
you need to add the binding to your wrangler config file.
```

如果 Cloudflare 部署或运行时报 `Invalid binding SESSION`，在 Cloudflare Dashboard 中创建一个 KV namespace，并在 Pages 项目的 `Settings -> Functions -> KV namespace bindings` 中添加：

| Binding name | KV namespace |
| --- | --- |
| `SESSION` | 选择你创建的 KV namespace |

如果后续改用 `wrangler.jsonc` 管理 Cloudflare 配置，可写成：

```jsonc
{
  "name": "goblinunde-blog",
  "kv_namespaces": [
    {
      "binding": "SESSION",
      "id": "<your-kv-namespace-id>"
    }
  ]
}
```

#### 4. 本地模拟 Cloudflare 构建

```bash
CF_PAGES=1 pnpm build
```

构建成功后，Cloudflare Pages 使用的输出目录是：

```text
dist/
```

Pagefind 搜索索引也会写入：

```text
dist/pagefind/
```

#### 5. Cloudflare CLI / Wrangler

当前仓库没有固定 `wrangler.jsonc`，使用 Dashboard Git 集成即可。如果后续需要 KV、R2、D1 或自定义 Pages Functions bindings，可以增加 `wrangler.jsonc`，并在 `astro.config.mjs` 中继续使用 `@astrojs/cloudflare` adapter。

Cloudflare adapter 已安装在 `package.json`：

```json
"@astrojs/cloudflare": "^12.6.12"
```

### GitHub Pages / 静态构建

如果只想静态部署：

```bash
make build
```

`make build` 会设置 `GITHUB_PAGES=true`，因此 `astro.config.mjs` 会输出纯静态站点并关闭 adapter。

### 手动 Git 推送流程

本仓库当前主要推送到 GitHub。日常建议使用显式 Git 流程：

```bash
git status
git add README.md
git commit -m "Update project README"
git push origin main
```

如果要使用 Makefile 自动提交和推送：

```bash
make deploy MSG="Update blog content"
```

仅本地构建检查：

```bash
make build
```

### Docker / Podman / 服务器

Docker、Podman 和服务器部署入口也已经放在 `Makefile` 中，分别使用：

```bash
make deploy-vercel
make deploy-docker
make deploy-podman
DEPLOY_SERVER=user@server DEPLOY_PATH=/var/www/blog make deploy-server
```

### 官方参考

- Vercel Astro 部署文档：<https://vercel.com/docs/frameworks/frontend/astro>
- Cloudflare Pages Astro 部署文档：<https://developers.cloudflare.com/pages/framework-guides/deploy-an-astro-site/>
- Cloudflare Pages 构建配置：<https://developers.cloudflare.com/pages/configuration/build-configuration/>
- Astro Cloudflare adapter：<https://docs.astro.build/en/guides/integrations-guide/cloudflare/>

## 致谢与许可

本项目基于 Twilight / astro-theme-retypeset 相关设计和 Astro 生态构建。

许可证见 [LICENSE](LICENSE)。

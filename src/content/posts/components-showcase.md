---
title: "博客自定义组件展示"
published: 2026-01-26
description: "展示博客的新颖自定义组件：渐变标题、卡片轮播、阅读进度和动态统计图表"
cover: "/assets/images/cover_math_2.png"
tags: [Components, UI, Design]
category: Guides
pinned: true
draft: false
---

# 博客自定义组件展示

本文介绍博客新增的自定义组件，展示其功能和使用方法。

---

## 一、渐变标题组件 (GradientTitle)

### 功能特点

- 🌈 6 种预设渐变效果
- ✨ 可选动画效果
- 📏 多种尺寸选项
- 🎨 支持自定义颜色

### 预设效果

| 渐变名称 | 颜色描述 |
|:---------|:---------|
| `rainbow` | 彩虹色 (红→黄→蓝→粉→蓝) |
| `sunset` | 日落色 (粉→红→米色) |
| `ocean` | 海洋色 (紫→蓝→青) |
| `forest` | 森林色 (深绿→浅绿→黄绿) |
| `purple` | 紫色系 (紫→粉→靛蓝) |
| `gold` | 金色系 (橙→黄→金) |

### 使用方法

```astro
---
import GradientTitle from '@components/custom/GradientTitle.astro';
---

<!-- 基础用法 -->
<GradientTitle text="标题文字" gradient="rainbow" size="xl" />

<!-- 带动画效果 -->
<GradientTitle text="动画标题" gradient="sunset" size="2xl" animated />

<!-- 自定义渐变 -->
<GradientTitle 
  text="自定义" 
  gradient="custom" 
  customColors="linear-gradient(90deg, #ff6b6b, #4ecdc4)" 
/>
```

### 参数说明

| 参数 | 类型 | 默认值 | 说明 |
|:-----|:-----|:-------|:-----|
| `text` | string | - | 标题文字 (必填) |
| `gradient` | string | `rainbow` | 渐变预设 |
| `size` | string | `xl` | 尺寸 (sm/md/lg/xl/2xl) |
| `animated` | boolean | `false` | 启用动画 |

---

## 二、卡片轮播组件 (CardCarousel)

### 功能特点

- 🔄 自动播放
- 👆 触摸滑动支持
- ⬅️➡️ 左右箭头导航
- 🔘 底部指示器
- 🖱️ 悬停暂停

### 使用方法

```astro
---
import CardCarousel from '@components/custom/CardCarousel.astro';

const items = [
  {
    title: "Rust 系统编程",
    description: "追求极致性能与内存安全",
    icon: "🦀"
  },
  {
    title: "LaTeX 排版",
    description: "专业论文排版",
    icon: "📝"
  },
  {
    title: "偏微分方程",
    description: "PINNs 物理信息神经网络",
    icon: "📐"
  }
];
---

<CardCarousel 
  items={items}
  autoplay={true}
  interval={4000}
  showIndicators={true}
  showArrows={true}
/>
```

### 参数说明

| 参数 | 类型 | 默认值 | 说明 |
|:-----|:-----|:-------|:-----|
| `items` | array | - | 卡片数据数组 (必填) |
| `autoplay` | boolean | `true` | 自动播放 |
| `interval` | number | `4000` | 切换间隔 (毫秒) |
| `showIndicators` | boolean | `true` | 显示指示器 |
| `showArrows` | boolean | `true` | 显示箭头 |

### 卡片数据结构

```typescript
interface CarouselItem {
  title: string;        // 标题 (必填)
  description?: string; // 描述
  image?: string;       // 图片 URL
  icon?: string;        // 图标 emoji
  link?: string;        // 链接
}
```

---

## 三、阅读进度组件 (ReadingProgress)

### 功能特点

- ⏱️ 预计阅读时间
- 📄 字数统计
- 📊 实时阅读进度
- 📑 章节快速导航
- 🔘 浮动章节指示器

### 使用方法

```astro
---
import ReadingProgress from '@components/custom/ReadingProgress.astro';
---

<ReadingProgress 
  wordCount={1500}
  headings={[
    { depth: 2, slug: "section-1", text: "第一章" },
    { depth: 2, slug: "section-2", text: "第二章" },
    { depth: 2, slug: "section-3", text: "第三章" }
  ]}
  wordsPerMinute={300}
  showChapterNav={true}
/>
```

### 参数说明

| 参数 | 类型 | 默认值 | 说明 |
|:-----|:-----|:-------|:-----|
| `wordCount` | number | - | 文章字数 (必填) |
| `headings` | array | `[]` | 标题数组 |
| `wordsPerMinute` | number | `300` | 阅读速度 |
| `showChapterNav` | boolean | `true` | 显示章节导航 |

---

## 四、动态统计图表 (StatsChart)

### 功能特点

- 🔢 数字递增动画
- 📊 动态进度条
- 🎨 6 种颜色主题
- 👀 滚动触发动画
- 📱 响应式网格布局

### 使用方法

```astro
---
import StatsChart from '@components/custom/StatsChart.astro';

const stats = [
  { label: "文章总数", value: 12, icon: "📝", color: "blue" },
  { label: "标签数量", value: 25, icon: "🏷️", color: "green" },
  { label: "分类数量", value: 5, icon: "📁", color: "purple" },
  { label: "总字数", value: 50000, icon: "✍️", color: "orange", suffix: "字" }
];
---

<StatsChart 
  title="博客统计"
  stats={stats}
  animated={true}
  layout="grid"
/>
```

### 参数说明

| 参数 | 类型 | 默认值 | 说明 |
|:-----|:-----|:-------|:-----|
| `stats` | array | - | 统计数据数组 (必填) |
| `title` | string | - | 标题 |
| `animated` | boolean | `true` | 启用动画 |
| `layout` | string | `grid` | 布局 (grid/row) |

### 颜色选项

支持的颜色：`blue`, `green`, `purple`, `orange`, `pink`, `cyan`

---

## 组件位置

所有自定义组件位于 `src/components/custom/` 目录：

```
src/components/custom/
├── GradientTitle.astro    # 渐变标题
├── CardCarousel.astro     # 卡片轮播
├── ReadingProgress.astro  # 阅读进度
├── StatsChart.astro       # 统计图表
└── index.ts               # 统一导出
```

---

## 在页面中使用

这些组件可以在 `.astro` 页面文件中使用，例如在 `about.astro` 或自定义页面中：

```astro
---
// src/pages/demo.astro
import Layout from '@layouts/Layout.astro';
import GradientTitle from '@components/custom/GradientTitle.astro';
import StatsChart from '@components/custom/StatsChart.astro';
---

<Layout>
  <GradientTitle text="演示页面" gradient="rainbow" animated />
  
  <StatsChart 
    stats={[
      { label: "访问量", value: 1000, color: "blue" }
    ]}
  />
</Layout>
```

---

:::tip[组件特性]

- ✅ 支持暗色模式
- ✅ 响应式设计
- ✅ 动画效果
- ✅ 触摸交互
- ✅ Swup 导航兼容

:::

这些组件为博客增添了现代化的交互体验！

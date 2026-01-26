---
title: "LaTeX 高级功能详解"
published: 2026-01-25
description: "深入探索 LaTeX 的高级排版功能，包括自定义宏、复杂公式、表格美化和专业文档排版技巧"
cover: "/assets/images/cover_math_1.png"
tags: [LaTeX, Typography, Mathematics]
category: Mathematics
draft: false
---

# LaTeX 高级功能详解

LaTeX 是科学和技术文档排版的黄金标准。本文深入探讨 LaTeX 的高级功能，帮助你创建专业水准的文档。

---

## 一、自定义数学宏

### 1.1 基本宏定义

在 LaTeX 中，使用 `\newcommand` 定义自定义命令可以大幅简化复杂公式的书写：

```latex
% 定义常用数学集合
\newcommand{\R}{\mathbb{R}}     % 实数集
\newcommand{\N}{\mathbb{N}}     % 自然数集
\newcommand{\Z}{\mathbb{Z}}     % 整数集
\newcommand{\C}{\mathbb{C}}     % 复数集
\newcommand{\Q}{\mathbb{Q}}     % 有理数集

% 定义微分算子
\newcommand{\pdv}[2]{\frac{\partial #1}{\partial #2}}
\newcommand{\dv}[2]{\frac{d #1}{d #2}}
```

使用效果：$\mathbb{R}$、$\mathbb{N}$、$\mathbb{Z}$、$\mathbb{C}$、$\mathbb{Q}$

### 1.2 带参数的宏

```latex
% 带默认参数的范数
\newcommand{\norm}[2][]{\left\|#2\right\|_{#1}}

% 使用示例
\norm{x}        % 输出 ||x||
\norm[2]{x}     % 输出 ||x||_2
\norm[\infty]{x} % 输出 ||x||_∞
```

效果演示：

$$
\|x\|_2 = \sqrt{\sum_{i=1}^n x_i^2}, \quad \|x\|_\infty = \max_i |x_i|
$$

---

## 二、复杂数学公式排版

### 2.1 多行公式对齐

使用 `align` 环境实现多行公式对齐：

$$
\begin{aligned}
\nabla \cdot \mathbf{E} &= \frac{\rho}{\varepsilon_0} \\
\nabla \cdot \mathbf{B} &= 0 \\
\nabla \times \mathbf{E} &= -\frac{\partial \mathbf{B}}{\partial t} \\
\nabla \times \mathbf{B} &= \mu_0 \mathbf{J} + \mu_0 \varepsilon_0 \frac{\partial \mathbf{E}}{\partial t}
\end{aligned}
$$

### 2.2 分段函数

使用 `cases` 环境定义分段函数：

$$
f(x) = \begin{cases}
x^2 & \text{if } x \geq 0 \\
-x^2 & \text{if } x < 0
\end{cases}
$$

### 2.3 矩阵与行列式

不同括号的矩阵表示：

$$
\begin{pmatrix} a & b \\ c & d \end{pmatrix}, \quad
\begin{bmatrix} a & b \\ c & d \end{bmatrix}, \quad
\begin{vmatrix} a & b \\ c & d \end{vmatrix} = ad - bc
$$

### 2.4 长公式折行

对于超长公式，使用 `multline` 或手动折行：

$$
\begin{aligned}
\mathcal{L}(\theta) &= \sum_{i=1}^{N} \left[ y_i \log \sigma(\theta^T x_i) + (1-y_i) \log(1 - \sigma(\theta^T x_i)) \right] \\
&\quad - \lambda \|\theta\|_2^2
\end{aligned}
$$

---

## 三、专业表格排版

### 3.1 三线表

学术论文推荐使用三线表格式：

| 模型 | 准确率 | F1-Score | 参数量 |
|:-----|:------:|:--------:|-------:|
| ResNet-50 | 76.13% | 0.761 | 25.6M |
| VGG-16 | 71.59% | 0.715 | 138.4M |
| EfficientNet-B0 | 77.10% | 0.770 | 5.3M |

### 3.2 LaTeX 表格代码

```latex
\begin{table}[htbp]
\centering
\caption{深度学习模型性能对比}
\begin{tabular}{lccc}
\toprule
模型 & 准确率 & F1-Score & 参数量 \\
\midrule
ResNet-50 & 76.13\% & 0.761 & 25.6M \\
VGG-16 & 71.59\% & 0.715 & 138.4M \\
EfficientNet-B0 & 77.10\% & 0.770 & 5.3M \\
\bottomrule
\end{tabular}
\end{table}
```

---

## 四、定理环境

### 4.1 定理、引理、证明

:::important[泰勒定理]
设函数 $f(x)$ 在包含 $a$ 的区间内有 $(n+1)$ 阶导数，则对该区间内的任意 $x$：

$$
f(x) = \sum_{k=0}^{n} \frac{f^{(k)}(a)}{k!}(x-a)^k + R_n(x)
$$

其中余项 $R_n(x) = \frac{f^{(n+1)}(\xi)}{(n+1)!}(x-a)^{n+1}$，$\xi$ 在 $a$ 与 $x$ 之间。
:::

### 4.2 证明示例

:::tip[证明]
欧拉公式 $e^{i\theta} = \cos\theta + i\sin\theta$ 的证明：

利用泰勒展开：
$$
e^{i\theta} = \sum_{n=0}^{\infty} \frac{(i\theta)^n}{n!} = \sum_{n=0}^{\infty} \frac{(-1)^n \theta^{2n}}{(2n)!} + i\sum_{n=0}^{\infty} \frac{(-1)^n \theta^{2n+1}}{(2n+1)!}
$$

恰好是 $\cos\theta$ 和 $\sin\theta$ 的泰勒展开。证毕。
:::

---

## 五、参考文献管理

### 5.1 BibTeX 条目

```bibtex
@article{einstein1905,
  author  = {Albert Einstein},
  title   = {Zur Elektrodynamik bewegter Körper},
  journal = {Annalen der Physik},
  year    = {1905},
  volume  = {322},
  number  = {10},
  pages   = {891--921}
}
```

### 5.2 引用样式

常用引用样式包括：

- **plain**: 按作者姓氏排序的数字编号
- **alpha**: 使用作者姓氏和年份组合的标签
- **apalike**: APA 格式
- **ieeetr**: IEEE 格式（适用于工程类论文）

---

## 六、常用数学符号速查

| 类别 | 符号 | LaTeX 代码 |
|:-----|:-----|:-----------|
| 希腊字母 | $\alpha, \beta, \gamma, \delta, \epsilon$ | `\alpha, \beta, \gamma, \delta, \epsilon` |
| 运算符 | $\sum, \prod, \int, \oint, \nabla$ | `\sum, \prod, \int, \oint, \nabla` |
| 关系符 | $\leq, \geq, \neq, \approx, \equiv$ | `\leq, \geq, \neq, \approx, \equiv` |
| 箭头 | $\to, \leftarrow, \Leftrightarrow, \mapsto$ | `\to, \leftarrow, \Leftrightarrow, \mapsto` |
| 集合 | $\in, \notin, \subset, \cup, \cap$ | `\in, \notin, \subset, \cup, \cap` |

---

## 总结

LaTeX 的高级功能使其成为学术写作的首选工具。掌握自定义宏、复杂公式排版、专业表格和定理环境，可以显著提高文档质量和写作效率。

:::note[推荐资源]

- [LaTeX Wikibook](https://en.wikibooks.org/wiki/LaTeX)
- [Overleaf 文档](https://www.overleaf.com/learn)
- [CTAN 宏包仓库](https://ctan.org/)

:::

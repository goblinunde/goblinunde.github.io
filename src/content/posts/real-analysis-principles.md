---
title: "实分析的三性原理"
published: 2026-01-22
description: "Littlewood 三原理：可测函数几乎是连续的、可测集几乎是开集的并、收敛几乎是一致的"
cover: "/assets/images/cover_math_1.png"
tags: [Mathematics, Real Analysis, Measure Theory]
category: Mathematics
draft: false
---

# 实分析的三性原理

Littlewood 三原理是实分析和测度论中最富有洞察力的观点之一。它揭示了可测对象与经典对象之间的深刻联系：**可测对象"几乎"就是我们熟悉的对象**。

---

## 一、Littlewood 三原理概述

英国数学家 John Edensor Littlewood 提出了测度论的三条指导原则：

:::important[Littlewood 三原理]

1. **每个可测集几乎是有限个开区间的并**
2. **每个可测函数几乎是连续的**
3. **每个点态收敛的函数列几乎是一致收敛的**

:::

这里"几乎"的含义是：除去一个任意小测度的例外集。

---

## 二、第一原理：可测集的结构

### 2.1 正则性定理

:::important[Lebesgue 可测集的正则性]
设 $E \subseteq \mathbb{R}$ 是 Lebesgue 可测集，$m(E) < \infty$。对任意 $\varepsilon > 0$，存在：

1. **开集 $G \supseteq E$**：$m(G \setminus E) < \varepsilon$
2. **闭集 $F \subseteq E$**：$m(E \setminus F) < \varepsilon$
3. **有限个开区间的并 $U$**：$m(E \triangle U) < \varepsilon$

:::

### 2.2 直观理解

可测集可以被开集从外部逼近，被闭集从内部逼近，逼近的精度可以任意高。

$$
F \subseteq E \subseteq G, \quad m(G \setminus F) < 2\varepsilon
$$

### 2.3 应用示例

Cantor 集 $C$ 是一个测度为 0 的完备集。对任意 $\varepsilon > 0$，存在开集 $G \supseteq C$，使得 $m(G) < \varepsilon$。

---

## 三、第二原理：Lusin 定理

### 3.1 定理陈述

:::important[Lusin 定理]
设 $E \subseteq \mathbb{R}$ 是有限测度的可测集，$f: E \to \mathbb{R}$ 是可测函数。对任意 $\varepsilon > 0$，存在闭集 $F \subseteq E$，使得：

1. $m(E \setminus F) < \varepsilon$
2. $f|_F$ 是连续的

:::

### 3.2 证明思路

**构造方法**：

1. 用简单函数逼近 $f$：$s_n \to f$ 点态
2. 由 Egorov 定理，存在 $E_n$ 使得 $s_n \to f$ 在 $E \setminus E_n$ 上一致收敛
3. 一致极限保持连续性
4. 适当选取 $F$，使 $f|_F$ 连续

### 3.3 经典例子

Dirichlet 函数 $D(x) = \mathbf{1}_{\mathbb{Q}}(x)$ 处处不连续，但在 $[0,1]$ 的任意 $\varepsilon$-子集上是连续的（因为该子集不含有理数时 $D \equiv 0$）。

---

## 四、第三原理：Egorov 定理

### 4.1 定理陈述

:::important[Egorov 定理]
设 $E$ 是有限测度的可测集，$\{f_n\}$ 是 $E$ 上的可测函数列，且 $f_n \to f$ 几乎处处。对任意 $\varepsilon > 0$，存在可测集 $A \subseteq E$，使得：

1. $m(E \setminus A) < \varepsilon$
2. $f_n \to f$ 在 $A$ 上一致收敛

:::

### 4.2 证明

**步骤 1**：定义
$$
E_n^k = \{x \in E : |f_m(x) - f(x)| < 1/k, \forall m \geq n\}
$$

**步骤 2**：对固定 $k$，$E_1^k \subseteq E_2^k \subseteq \cdots$，且 $\bigcup_n E_n^k = E$（几乎处处收敛）。

**步骤 3**：由测度连续性，$m(E_n^k) \to m(E)$。选 $n_k$ 使得 $m(E \setminus E_{n_k}^k) < \varepsilon/2^k$。

**步骤 4**：令 $A = \bigcap_k E_{n_k}^k$，则 $m(E \setminus A) < \varepsilon$，且 $f_n \to f$ 在 $A$ 上一致收敛。$\square$

### 4.3 反例：无穷测度情形

在 $\mathbb{R}$ 上，$f_n = \mathbf{1}_{[n, n+1]}$ 点态收敛到 0，但在任何正测度集上都不能一致收敛（可构造反例）。

---

## 五、三原理的统一视角

### 5.1 核心思想

三原理的本质是：**测度论对象与经典分析对象之间只有"零测集"的差异**。

| 经典对象 | 测度论对象 | 联系 |
|:---------|:-----------|:-----|
| 开集/闭集 | 可测集 | 正则性 |
| 连续函数 | 可测函数 | Lusin 定理 |
| 一致收敛 | 点态收敛 | Egorov 定理 |

### 5.2 哲学意义

Littlewood 评论："测度论中没有真正新的困难，只有原有困难的'几乎处处'版本。"

---

## 六、应用实例

### 6.1 Riemann 可积性判别

:::tip[定理]
有界函数 $f: [a,b] \to \mathbb{R}$ Riemann 可积当且仅当其不连续点集是零测集。
:::

这正是第二原理的体现：Riemann 可积函数"几乎"连续。

### 6.2 Fourier 级数收敛

Carleson 定理：$L^2$ 函数的 Fourier 级数几乎处处收敛。

由 Egorov 定理，在任意小测度集的补集上，收敛是一致的。

---

## 总结

Littlewood 三原理是实分析的指路明灯：

1. **可测集 ≈ 开集的并**
2. **可测函数 ≈ 连续函数**
3. **点态收敛 ≈ 一致收敛**

理解这三条原理，就掌握了测度论与经典分析之间的桥梁。

:::note[推荐阅读]

- Royden. *Real Analysis* (经典教材)
- Folland. *Real Analysis: Modern Techniques and Applications*
- 周民强. *实变函数论*

:::

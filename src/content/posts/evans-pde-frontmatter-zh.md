---
title: "Evans《偏微分方程》第二版：前言、书目信息与目录中译"
published: 2026-05-08
description: "整理 Lawrence C. Evans《Partial Differential Equations》第二版第一章之前的书目信息、前言要点和完整目录中译。"
cover: "/assets/images/cover_math_2.png"
pinned: false
tags: [PDE, Evans, Textbook, Translation]
category: Mathematics
draft: false
lang: zh
sourceLink: "https://www.ams.org/bookpages/gsm-19"
---

本文整理 Lawrence C. Evans 的研究生教材 *Partial Differential Equations, Second Edition* 在第一章之前的内容，包括书目信息、献词、第二版前言、第一版前言和全书目录中译。整理依据为本地 PDF `References/PDE.pdf` 的前置页。

这不是逐字排版复刻，而是面向后续博客阅读计划的译注式整理：版权页只保留有用书目信息；前言保留作者写作意图、第二版变化和阅读提示；目录尽量完整翻译，方便之后逐章建立索引。

## 1. 书籍基本信息

| 项目 | 信息 |
|---|---|
| 英文书名 | *Partial Differential Equations* |
| 中文书名 | 《偏微分方程》 |
| 版本 | 第二版 |
| 作者 | Lawrence C. Evans |
| 作者单位 | University of California, Berkeley, Department of Mathematics |
| 丛书 | Graduate Studies in Mathematics, Volume 19 |
| 出版机构 | American Mathematical Society |
| 第一版 | 1998 年，1999 年与 2002 年修订重印 |
| 第二版 | 2010 年 |
| 第二版修订重印 | 2015 年修订重印；2022 年 AMS 重印 |
| ISBN | 978-0-8218-4974-3 |
| Softcover ISBN | 978-1-4704-6942-9 |
| 2010 数学主题分类 | Primary 35-XX；Secondary 49-XX, 47Hxx |

其中 `35-XX` 对应偏微分方程，`49-XX` 对应变分法与最优控制，`47Hxx` 涉及非线性算子与相关泛函分析主题。这也基本提示了全书的主线：PDE 理论不是只讲三大方程，而是逐步走向弱解、Sobolev 空间、变分法、守恒律、Hamilton-Jacobi 方程和非线性波方程。

作者将本书献给父母 Lawrence S. Evans 与 Louise J. Evans。

## 2. 第二版前言译注

第二版前言首先感谢了十余年间为第一版提出建议和勘误的读者，也感谢 AMS 工作人员和 NSF 对作者研究工作的支持。作者说明自己会继续在个人主页维护错误列表。

Evans 用一个关于托尔斯泰写作《战争与和平》的文学类比说明：面对一个大主题写一本大书，最大的诱惑就是想把所有内容都放进去。偏微分方程本身范围极广，一本教材不可能真正穷尽所有重要方向。

在这种取舍下，第二版尽量加入了更多新的 PDE 主题，尤其是新增的第 12 章“非线性波方程”。除此之外，第二版还加入或扩展了以下内容：

- 变分法中的 Noether 定理；
- 变分法中的局部极小子；
- Radon 变换；
- 反应-扩散系统中的 Turing 不稳定性；
- 解的爆破现象；
- 群速度与相速度；
- 若干其他专题的重写与扩充；
- 更新并大幅增加书目中的教材和专著引用；
- 将研究论文引用更多移入正文；
- 调整许多记号和措辞；
- 新增约 80 道习题，全书习题总数超过 200 道。

第二版前言最后还提到，第 10 章习题中安排了一个“游艇竞赛”问题，回应前文那个关于大书总会遗漏场景的幽默比喻。

2022 年第三次印刷说明：截至 2022 年 2 月，第二版第三次印刷修正了已知错误。

## 3. 第一版前言译注

第一版前言更重要，因为它解释了 Evans 这本书的写作立场。

作者说，本书试图广泛介绍偏微分方程理论中的许多重要主题，并特别强调现代方法。书中当然包含常见线性 PDE 的显式解公式，但也大量讨论 Sobolev 空间中的能量方法、变分法、守恒律等内容。

### 3.1 PDE 不应局限于两个自变量

Evans 反对把 PDE 主要写成两个变量的函数问题，例如只讨论 $u(x,y)$ 或 $u(x,t)$。这种写法虽然适合入门，但会误导读者，因为现代 PDE 理论中的许多线性和非线性方程都可以在任意维数中严格处理。

他也不太赞成过度依赖“分类”来理解 PDE。二元情形中的分类确实有用，但容易让人误以为一般 PDE 存在一种统一、普遍、总是有效的分类图景。

### 3.2 非线性方程非常重要

作者的判断是：整体而言，人们对线性 PDE 知道得很多，而对非线性 PDE 知道得太少。因此本书很早就引入非线性概念，并尽量在各处强调线性理论的非线性对应物。

这也是本书区别于只围绕 Laplace 方程、热方程、波方程展开的入门教材之处。它的目标并不只是会算几个经典公式，而是进入现代 PDE 的思维方式。

### 3.3 广义解或弱解是核心

许多 PDE，特别是非线性一阶方程，一般不存在光滑解。因此必须建立合适的广义解或弱解概念。

这件事重要但微妙。书中很多困难内容都与适当定义的弱解的唯一性有关。也就是说，放宽“解”的光滑性要求只是第一步，真正的难点在于证明这个较弱意义下的解仍然是数学上合理的。

### 3.4 PDE 不只是泛函分析的分支

某些 PDE 可以被看成 Banach 空间之间的抽象算子问题，这当然很有用。但 Evans 明确反对过度抽象化：如果只强调抽象泛函分析，而忽视微积分估计和测度论估计，就会限制对 PDE 的理解。

这句话很能概括本书风格：它会使用泛函分析，但不会把 PDE 简化成纯粹的算子理论。

### 3.5 记号是一件麻烦事

作者承认 PDE 记号很难统一。他试图建立一套能覆盖本书主要方程类型的统一记号，但这有时会和某些子领域的惯例冲突。

阅读时尤其需要熟悉附录 A 中的记号，特别是多重指标记号。

### 3.6 好理论几乎和显式公式一样有用

这条原则决定了全书结构。全书分为三大部分，并大致模仿 PDE 理论的历史发展：

- 第一部分：寻找解的显式公式；
- 第二部分：放弃普遍显式公式，建立线性 PDE 的一般存在性和性质理论；
- 第三部分：面向重要非线性 PDE 建立现代一般理论。

### 3.7 阅读方式提醒

作者强调，每一节内部都尽量做到严格和完整，但这并不意味着内容总是从易到难排列。书中早期就会出现困难证明和复杂计算，后面也会有相对容易的思想。第一次阅读时，可以跳过一些较偏、较难的证明。

作者还明确说明：这是一本教材，不是参考书。它更重视在相对简单的背景下解释基本思想，而不是给出每个定理最尖锐、最一般的版本。更精确和更一般的结果可以到研究论文和高级专著中查找。

第一版前言还感谢了许多同事、学生和读者的建议。其中 Tai-Ping Liu 曾为现在的第 11 章写出早期草稿。作者也感谢了参与讲义录入和更新的工作人员，并说明写作期间获得 NSF 支持。

## 4. 全书目录中译

### 前置部分

| 英文标题 | 中文翻译 | 页码 |
|---|---|---:|
| Preface to the second edition | 第二版前言 | xi |
| Preface to the first edition | 第一版前言 | xiii |

### Chapter 1. Introduction

| 英文标题 | 中文翻译 | 页码 |
|---|---|---:|
| Chapter 1. Introduction | 第 1 章 引言 | 1 |
| Partial Differential Equations | 偏微分方程 | 1 |
| Examples | 例子 | 3 |
| Strategies for Studying PDE | 研究 PDE 的策略 | 6 |
| Overview | 全书概览 | 8 |
| Problems | 习题 | 11 |
| References | 参考文献 | 12 |

### Part I. Representation Formulas for Solutions

第一部分标题可译为“解的表示公式”。这一部分关注能够显式或半显式写出解的 PDE。

#### Chapter 2. Four Important Linear Partial Differential Equations

| 英文标题 | 中文翻译 | 页码 |
|---|---|---:|
| Chapter 2. Four Important Linear Partial Differential Equations | 第 2 章 四类重要线性偏微分方程 | 17 |
| Transport Equation | 输运方程 | 17 |
| Laplace's Equation | Laplace 方程 | 19 |
| Heat Equation | 热方程 | 42 |
| Wave Equation | 波方程 | 63 |
| Problems | 习题 | 81 |
| References | 参考文献 | 86 |

#### Chapter 3. Nonlinear First-Order PDE

| 英文标题 | 中文翻译 | 页码 |
|---|---|---:|
| Chapter 3. Nonlinear First-Order PDE | 第 3 章 非线性一阶 PDE | 89 |
| Complete Integrals, Envelopes | 完全积分与包络 | 90 |
| Characteristics | 特征线方法 | 94 |
| Introduction to Hamilton-Jacobi Equations | Hamilton-Jacobi 方程导论 | 110 |
| Introduction to Conservation Laws | 守恒律导论 | 130 |
| Problems | 习题 | 154 |
| References | 参考文献 | 158 |

#### Chapter 4. Other Ways to Represent Solutions

| 英文标题 | 中文翻译 | 页码 |
|---|---|---:|
| Chapter 4. Other Ways to Represent Solutions | 第 4 章 表示解的其他方法 | 159 |
| Separation of Variables | 分离变量法 | 159 |
| Similarity Solutions | 相似解 | 167 |
| Transform Methods | 变换方法 | 177 |
| Converting Nonlinear into Linear PDE | 将非线性 PDE 化为线性 PDE | 195 |
| Asymptotics | 渐近方法 | 200 |
| Power Series | 幂级数 | 220 |
| Problems | 习题 | 231 |
| References | 参考文献 | 236 |

### Part II. Theory for Linear Partial Differential Equations

第二部分标题可译为“线性偏微分方程理论”。这一部分从显式公式转向弱解、能量估计、存在性、唯一性和正则性。

#### Chapter 5. Sobolev Spaces

| 英文标题 | 中文翻译 | 页码 |
|---|---|---:|
| Chapter 5. Sobolev Spaces | 第 5 章 Sobolev 空间 | 239 |
| Hölder Spaces | Hölder 空间 | 240 |
| Sobolev Spaces | Sobolev 空间 | 241 |
| Approximation | 逼近 | 249 |
| Extensions | 延拓 | 253 |
| Traces | 迹 | 256 |
| Sobolev Inequalities | Sobolev 不等式 | 260 |
| Compactness | 紧性 | 270 |
| Additional Topics | 补充专题 | 273 |
| Other Spaces of Functions | 其他函数空间 | 282 |
| Problems | 习题 | 289 |
| References | 参考文献 | 292 |

#### Chapter 6. Second-Order Elliptic Equations

| 英文标题 | 中文翻译 | 页码 |
|---|---|---:|
| Chapter 6. Second-Order Elliptic Equations | 第 6 章 二阶椭圆方程 | 293 |
| Definitions | 定义 | 293 |
| Existence of Weak Solutions | 弱解的存在性 | 297 |
| Regularity | 正则性 | 307 |
| Maximum Principles | 极大值原理 | 323 |
| Eigenvalues and Eigenfunctions | 特征值与特征函数 | 333 |
| Problems | 习题 | 343 |
| References | 参考文献 | 348 |

#### Chapter 7. Linear Evolution Equations

| 英文标题 | 中文翻译 | 页码 |
|---|---|---:|
| Chapter 7. Linear Evolution Equations | 第 7 章 线性演化方程 | 349 |
| Second-Order Parabolic Equations | 二阶抛物方程 | 349 |
| Second-Order Hyperbolic Equations | 二阶双曲方程 | 375 |
| Systems of Hyperbolic First-Order Equations | 一阶双曲方程组 | 396 |
| Semigroup Theory | 半群理论 | 409 |
| Problems | 习题 | 420 |
| References | 参考文献 | 423 |

### Part III. Theory for Nonlinear Partial Differential Equations

第三部分标题可译为“非线性偏微分方程理论”。这一部分不再有统一套路，而是按不同非线性结构分别处理。

#### Chapter 8. The Calculus of Variations

| 英文标题 | 中文翻译 | 页码 |
|---|---|---:|
| Chapter 8. The Calculus of Variations | 第 8 章 变分法 | 427 |
| Introduction | 引言 | 427 |
| Existence of Minimizers | 极小子的存在性 | 437 |
| Regularity | 正则性 | 454 |
| Constraints | 约束 | 458 |
| Critical Points | 临界点 | 471 |
| Invariance, Noether's Theorem | 不变性与 Noether 定理 | 481 |
| Problems | 习题 | 489 |
| References | 参考文献 | 494 |

#### Chapter 9. Nonvariational Techniques

| 英文标题 | 中文翻译 | 页码 |
|---|---|---:|
| Chapter 9. Nonvariational Techniques | 第 9 章 非变分方法 | 495 |
| Monotonicity Methods | 单调性方法 | 495 |
| Fixed Point Methods | 不动点方法 | 501 |
| Method of Subsolutions and Supersolutions | 下解与上解方法 | 510 |
| Nonexistence of Solutions | 解的不存在性 | 514 |
| Geometric Properties of Solutions | 解的几何性质 | 521 |
| Gradient Flows | 梯度流 | 526 |
| Problems | 习题 | 538 |
| References | 参考文献 | 541 |

#### Chapter 10. Hamilton-Jacobi Equations

| 英文标题 | 中文翻译 | 页码 |
|---|---|---:|
| Chapter 10. Hamilton-Jacobi Equations | 第 10 章 Hamilton-Jacobi 方程 | 543 |
| Introduction, Viscosity Solutions | 引言与黏性解 | 543 |
| Uniqueness | 唯一性 | 550 |
| Control Theory, Dynamic Programming | 控制理论与动态规划 | 554 |
| Problems | 习题 | 566 |
| References | 参考文献 | 569 |

#### Chapter 11. Systems of Conservation Laws

| 英文标题 | 中文翻译 | 页码 |
|---|---|---:|
| Chapter 11. Systems of Conservation Laws | 第 11 章 守恒律方程组 | 571 |
| Introduction | 引言 | 571 |
| Riemann's Problem | Riemann 问题 | 582 |
| Systems of Two Conservation Laws | 二元守恒律方程组 | 595 |
| Entropy Criteria | 熵判据 | 601 |
| Problems | 习题 | 613 |
| References | 参考文献 | 616 |

#### Chapter 12. Nonlinear Wave Equations

| 英文标题 | 中文翻译 | 页码 |
|---|---|---:|
| Chapter 12. Nonlinear Wave Equations | 第 12 章 非线性波方程 | 617 |
| Introduction | 引言 | 617 |
| Existence of Solutions | 解的存在性 | 620 |
| Semilinear Wave Equations | 半线性波方程 | 627 |
| Critical Power Nonlinearity | 临界幂非线性 | 636 |
| Nonexistence of Solutions | 解的不存在性 | 642 |
| Problems | 习题 | 647 |
| References | 参考文献 | 651 |

### Appendices

| 英文标题 | 中文翻译 | 页码 |
|---|---|---:|
| Appendices | 附录 | 653 |
| Notation | 记号 | 653 |
| Inequalities | 不等式 | 661 |
| Calculus | 微积分 | 665 |
| Functional Analysis | 泛函分析 | 674 |
| Measure Theory | 测度论 | 684 |
| Bibliography | 参考书目 | 689 |
| Index | 索引 | 703 |

## 5. 读书路线提示

从前言和目录可以看出，Evans 这本书不是“数学物理方程公式手册”，而是一条现代 PDE 理论路线。

如果第一次读，可以按下面的顺序处理：

1. 先看附录 A 的记号，尤其是多重指标记号；
2. 阅读第 1 章，建立 PDE、适定性、弱解和全书结构的整体图景；
3. 学第 2 章四个基本线性方程，建立输运、调和、扩散、波动四类原型；
4. 进入第 5 章 Sobolev 空间，为第 6、7 章的弱解理论做准备；
5. 读第 6、7 章，理解线性椭圆、抛物、双曲方程的现代理论；
6. 再回到第 3、8、9、10、11、12 章，按兴趣进入非线性方向。

如果目标是研究 PDE 理论，本书的关键词不是“会不会算出显式解”，而是：

- 是否能建立合适的解概念；
- 是否能证明存在性；
- 是否能证明唯一性；
- 解是否连续依赖于数据；
- 弱解是否具有进一步正则性；
- 非线性结构是否提供额外估计或守恒量。

这也是后续整理这本书时应当抓住的主线。

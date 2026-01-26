---
title: "LaTeX 数学公式测试"
published: 2026-01-26
description: "测试 KaTeX 数学公式渲染，包含自定义宏和复杂公式"
category: "Mathematics"
tags:
  - LaTeX
  - Math
  - Deep Learning
---

# LaTeX 数学公式测试

本文用于测试博客的数学公式渲染能力，包含自定义宏和各种复杂公式。

## 自定义数学宏测试

### 数学集合

- 实数集 $\R$
- 自然数 $\N$
- 整数集 $\Z$
- 复数集 $\C$
- 有理数 $\Q$

### 微分算子

偏导数：$\pdv{f}{x}$ 表示 $f$ 对 $x$ 的偏导

全导数：$\dv{y}{x}$

梯度：$\grad f = \nabla f$

拉普拉斯算子：$\laplacian u = \nabla^2 u$

### 深度学习常用

期望：$\expect[X]$

方差：$\var(X)$

Softmax：$\softmax(x_i)$

ReLU：$\relu(x) = \max(0, x)$

最大化：$\argmax_\theta \mathcal{L}(\theta)$

最小化：$\argmin_\theta \mathcal{L}(\theta)$

---

## 行内公式

著名的质能方程 $E = mc^2$ 由爱因斯坦提出。

欧拉公式 $e^{i\pi} + 1 = 0$ 被誉为数学中最美丽的公式。

---

## 块级公式

### 高斯积分

$$
\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
$$

### 傅里叶变换

$$
\hat{f}(\xi) = \int_{-\infty}^{\infty} f(x) e^{-2\pi i x \xi} dx
$$

### 热传导方程

$$
\pdv{u}{t} = \alpha \laplacian u
$$

### 薛定谔方程

$$
i\hbar \pdv{\Psi}{t} = -\frac{\hbar^2}{2m} \laplacian \Psi + V\Psi
$$

---

## 矩阵与行列式

### 矩阵乘法

$$
\begin{pmatrix}
a_{11} & a_{12} \\
a_{21} & a_{22}
\end{pmatrix}
\begin{pmatrix}
b_{11} & b_{12} \\
b_{21} & b_{22}
\end{pmatrix}
=
\begin{pmatrix}
a_{11}b_{11} + a_{12}b_{21} & a_{11}b_{12} + a_{12}b_{22} \\
a_{21}b_{11} + a_{22}b_{21} & a_{21}b_{12} + a_{22}b_{22}
\end{pmatrix}
$$

### 行列式

$$
\det(A) = \begin{vmatrix}
a & b & c \\
d & e & f \\
g & h & i
\end{vmatrix}
= a(ei - fh) - b(di - fg) + c(dh - eg)
$$

---

## 深度学习公式

### 交叉熵损失

$$
\mathcal{L} = -\frac{1}{N} \sum_{i=1}^{N} \sum_{c=1}^{C} y_{ic} \log(\hat{y}_{ic})
$$

### Softmax 函数

$$
\softmax(z_i) = \frac{e^{z_i}}{\sum_{j=1}^{K} e^{z_j}}
$$

### 反向传播链式法则

$$
\pdv{\mathcal{L}}{w} = \pdv{\mathcal{L}}{y} \cdot \pdv{y}{z} \cdot \pdv{z}{w}
$$

### 物理信息神经网络 (PINNs) 残差

$$
\mathcal{L}_{\text{physics}} = \| \pdv{u}{t} - \nu \laplacian u + \mathbf{u} \cdot \grad u + \grad p \|^2
$$

---

## Admonition 测试

> [!NOTE]
> 这是一个注释提示框，用于提供额外信息。

> [!TIP]
> 这是一个技巧提示框，用于分享最佳实践。

> [!IMPORTANT]
> 这是一个重要提示框，用于强调关键信息。

> [!WARNING]
> 这是一个警告提示框，用于提醒潜在问题。

> [!CAUTION]
> 这是一个危险提示框，用于警示严重风险。

---

## 代码块测试

```python
import torch
import torch.nn as nn

class PINN(nn.Module):
    """Physics-Informed Neural Network"""
    def __init__(self, layers):
        super().__init__()
        self.network = nn.Sequential(*[
            nn.Linear(layers[i], layers[i+1])
            for i in range(len(layers) - 1)
        ])
    
    def forward(self, x, t):
        # 💡 Input: spatial coordinate x, temporal coordinate t
        inputs = torch.cat([x, t], dim=1)
        return self.network(inputs)
```

---

渲染完成！如果你能看到上述所有数学公式正确渲染，说明 LaTeX 配置成功。

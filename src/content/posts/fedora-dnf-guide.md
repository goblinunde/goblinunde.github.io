---
title: "Fedora 系统与 DNF 包管理器完全指南"
published: 2026-01-15
description: "深入了解 Fedora Linux 的特点、DNF 包管理器的使用技巧和系统配置最佳实践"
cover: "/assets/images/cover_linux.png"
tags: [Linux, Fedora, DNF, Package Manager]
category: Linux
draft: false
---

# Fedora 系统与 DNF 包管理器完全指南

Fedora 是由 Red Hat 赞助的社区驱动 Linux 发行版，以其前沿技术和稳定性著称。本文详细介绍 Fedora 的特点和 DNF 包管理器的使用。

---

## 一、Fedora 简介

### 1.1 什么是 Fedora？

:::important[Fedora 定位]
Fedora 是 Red Hat Enterprise Linux (RHEL) 的上游项目，新技术首先在 Fedora 测试，成熟后进入 RHEL。
:::

| 特性 | 描述 |
|:-----|:-----|
| **发布周期** | 每 6 个月一个新版本 |
| **支持周期** | 每个版本支持约 13 个月 |
| **包格式** | RPM (Red Hat Package Manager) |
| **包管理器** | DNF (Dandified YUM) |
| **默认桌面** | GNOME (Workstation 版) |
| **内核** | 通常是最新稳定版 |

### 1.2 Fedora 版本

| 版本 | 适用场景 |
|:-----|:---------|
| **Fedora Workstation** | 桌面用户，GNOME 环境 |
| **Fedora Server** | 服务器部署 |
| **Fedora IoT** | 物联网设备 |
| **Fedora CoreOS** | 容器化工作负载 |
| **Fedora Silverblue** | 不可变桌面系统 |
| **Fedora Spins** | KDE, Xfce, LXDE 等变体 |

### 1.3 Fedora 的优势

1. **技术前沿**：最新内核、GNOME、驱动
2. **纯净体验**：接近上游原版软件
3. **安全性**：SELinux 默认启用
4. **社区活跃**：庞大的开发者社区
5. **文档完善**：官方文档和 Wiki 质量高

---

## 二、DNF 包管理器

### 2.1 DNF 简介

DNF (Dandified YUM) 是 Fedora 22+ 的默认包管理器，替代了旧版 YUM。

**优势**：

- 更快的依赖解析
- 更小的内存占用
- 更好的 API 设计
- Python 3 原生支持

### 2.2 基础命令

#### 查询软件包

```bash
# 搜索软件包
dnf search <关键词>
dnf search python

# 查看软件包信息
dnf info <包名>
dnf info neovim

# 列出已安装的包
dnf list installed

# 列出可用更新
dnf list updates

# 查看包文件列表
dnf repoquery -l <包名>

# 查找文件属于哪个包
dnf provides /usr/bin/vim
```

#### 安装与卸载

```bash
# 安装软件包
sudo dnf install <包名>
sudo dnf install neovim tmux htop

# 安装本地 RPM 文件
sudo dnf install ./package.rpm

# 重新安装
sudo dnf reinstall <包名>

# 卸载软件包
sudo dnf remove <包名>

# 卸载并移除依赖
sudo dnf autoremove <包名>
```

#### 系统更新

```bash
# 检查更新
dnf check-update

# 更新所有软件包
sudo dnf upgrade

# 更新指定包
sudo dnf upgrade <包名>

# 更新到最新版本（含版本跨越）
sudo dnf distro-sync

# 系统版本升级 (如 F42 -> F43)
sudo dnf system-upgrade download --releasever=43
sudo dnf system-upgrade reboot
```

### 2.3 软件组管理

```bash
# 列出所有软件组
dnf group list

# 查看组信息
dnf group info "Development Tools"

# 安装软件组
sudo dnf group install "Development Tools"
sudo dnf group install @development-tools  # 简写

# 移除软件组
sudo dnf group remove "Development Tools"
```

### 2.4 仓库管理

```bash
# 列出所有仓库
dnf repolist
dnf repolist all  # 包含禁用的

# 启用/禁用仓库
sudo dnf config-manager --set-enabled <仓库名>
sudo dnf config-manager --set-disabled <仓库名>

# 添加第三方仓库
sudo dnf config-manager --add-repo <URL>

# 清理缓存
sudo dnf clean all
sudo dnf clean packages  # 只清理下载的包
sudo dnf makecache       # 重建缓存
```

---

## 三、常用第三方仓库

### 3.1 RPM Fusion

提供 Fedora 官方仓库不包含的软件（专有驱动、多媒体编解码器等）：

```bash
# 安装 RPM Fusion Free
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

# 安装 RPM Fusion NonFree
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# 安装多媒体编解码器
sudo dnf install ffmpeg ffmpeg-libs libva libva-utils
sudo dnf group install multimedia
```

### 3.2 Flathub (Flatpak)

```bash
# 添加 Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# 安装 Flatpak 应用
flatpak install flathub com.spotify.Client
flatpak install flathub com.visualstudio.code
```

### 3.3 COPR (社区仓库)

```bash
# 启用 COPR 仓库
sudo dnf copr enable <用户名>/<项目名>

# 示例：安装 Lazygit
sudo dnf copr enable atim/lazygit
sudo dnf install lazygit
```

---

## 四、DNF 高级用法

### 4.1 历史记录与回滚

```bash
# 查看历史记录
dnf history
dnf history info <ID>

# 撤销操作
sudo dnf history undo <ID>

# 重做操作
sudo dnf history redo <ID>

# 回滚到指定时间点
sudo dnf history rollback <ID>
```

### 4.2 模块化 (Modularity)

Fedora 支持同一软件的多个版本流：

```bash
# 列出可用模块
dnf module list

# 查看模块信息
dnf module info nodejs

# 启用特定版本
sudo dnf module enable nodejs:18

# 安装模块
sudo dnf module install nodejs:18

# 切换版本
sudo dnf module switch-to nodejs:20
```

### 4.3 自动更新

```bash
# 安装自动更新服务
sudo dnf install dnf-automatic

# 配置 /etc/dnf/automatic.conf
# apply_updates = yes

# 启用定时器
sudo systemctl enable --now dnf-automatic.timer

# 检查定时器状态
systemctl status dnf-automatic.timer
```

---

## 五、DNF 配置优化

### 5.1 配置文件

主配置文件：`/etc/dnf/dnf.conf`

```ini
[main]
gpgcheck=1
installonly_limit=3
clean_requirements_on_remove=True

# 💡 性能优化
fastestmirror=True      # 选择最快镜像
max_parallel_downloads=10  # 并行下载数
deltarpm=True           # 使用增量 RPM

# 💡 保留更多内核版本
installonly_limit=5

# 💡 默认确认安装
defaultyes=True
```

### 5.2 使用国内镜像

```bash
# 生成 fastestmirror 缓存
sudo dnf makecache

# 或手动配置镜像 (编辑 /etc/yum.repos.d/fedora.repo)
# baseurl=https://mirrors.tuna.tsinghua.edu.cn/fedora/releases/$releasever/Everything/$basearch/os/
```

### 5.3 常用别名

在 `~/.bashrc` 中添加：

```bash
# DNF 别名
alias dnfi='sudo dnf install'
alias dnfr='sudo dnf remove'
alias dnfu='sudo dnf upgrade'
alias dnfs='dnf search'
alias dnfc='sudo dnf clean all'
```

---

## 六、系统维护

### 6.1 清理系统

```bash
# 清理 DNF 缓存
sudo dnf clean all

# 移除孤立包
sudo dnf autoremove

# 移除旧内核 (保留当前和一个备用)
sudo dnf remove --oldinstallonly --setopt installonly_limit=2 kernel

# 清理 Flatpak 无用数据
flatpak uninstall --unused
```

### 6.2 系统版本升级

```bash
# 1. 更新当前系统
sudo dnf upgrade --refresh

# 2. 安装升级插件
sudo dnf install dnf-plugin-system-upgrade

# 3. 下载新版本包
sudo dnf system-upgrade download --releasever=43

# 4. 重启并执行升级
sudo dnf system-upgrade reboot

# 5. 升级后清理
sudo dnf system-upgrade clean
sudo dnf autoremove
```

### 6.3 常见问题处理

```bash
# 修复损坏的包数据库
sudo dnf check
sudo rpm --rebuilddb

# 强制重新安装包
sudo dnf reinstall <包名>

# 跳过损坏的包更新
sudo dnf upgrade --exclude=<问题包>

# 导入 GPG 密钥
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-43-primary
```

---

## 七、我的 Fedora 配置

作为 Fedora 43 用户，以下是我的常用配置：

### 7.1 基础软件安装

```bash
# 开发工具
sudo dnf install git neovim tmux htop btop

# 现代 CLI 工具
sudo dnf install bat lsd fd-find ripgrep

# 开发环境
sudo dnf install gcc gcc-c++ make cmake
sudo dnf install python3-pip python3-devel

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### 7.2 GNOME 扩展

```bash
# 安装扩展管理工具
sudo dnf install gnome-extensions-app gnome-tweaks

# 常用扩展
# - Dash to Dock
# - AppIndicator Support
# - Blur my Shell
# - Clipboard Indicator
```

### 7.3 系统信息

```bash
# 查看系统信息
cat /etc/fedora-release
# Fedora release 43 (Forty Three)

uname -r
# 6.x.x-xxx.fc43.x86_64

dnf --version
# 4.x.x
```

---

## 总结

| 操作 | 命令 |
|:-----|:-----|
| 搜索软件 | `dnf search <关键词>` |
| 安装软件 | `sudo dnf install <包名>` |
| 卸载软件 | `sudo dnf remove <包名>` |
| 更新系统 | `sudo dnf upgrade` |
| 清理缓存 | `sudo dnf clean all` |
| 移除孤立包 | `sudo dnf autoremove` |
| 系统升级 | `sudo dnf system-upgrade` |

:::tip[Fedora 使用建议]

1. 定期执行 `sudo dnf upgrade`
2. 启用 RPM Fusion 获取更多软件
3. 配置 `fastestmirror` 和并行下载
4. 使用 `dnf history` 追踪变更
5. 升级前备份重要数据

:::

:::note[参考资源]

- [Fedora 官方文档](https://docs.fedoraproject.org/)
- [DNF 官方文档](https://dnf.readthedocs.io/)
- [RPM Fusion](https://rpmfusion.org/)
- [Fedora 中文社区](https://zh.fedoracommunity.org/)

:::

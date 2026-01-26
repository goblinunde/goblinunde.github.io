# ===================================================================
# Twilight Blog - Makefile
# ===================================================================
# 博客管理工具：部署、源码管理、文章管理等
# 使用: make <target>
# ===================================================================

.PHONY: help dev build preview clean deploy push article draft list install check format track quick-deploy

# 💡 默认目标：显示帮助信息
help:
	@echo "╔═══════════════════════════════════════════════════════════╗"
	@echo "║         Twilight Blog - 管理工具                          ║"
	@echo "╚═══════════════════════════════════════════════════════════╝"
	@echo ""
	@echo "📖 首次使用:"
	@echo "  make setup                          首次设置向导"
	@echo "  make guide                          查看用户引导"
	@echo ""
	@echo "📝 文章管理 - 基础:"
	@echo "  make article TITLE=\"标题\"           创建新文章"
	@echo "  make draft TITLE=\"标题\"             创建草稿"
	@echo "  make list                           列出所有文章"
	@echo "  make info FILE=文章.md              查看文章详情"
	@echo "  make search KEYWORD=\"关键词\"        搜索文章"
	@echo ""
	@echo "� 文章管理 - 操作:"
	@echo "  make publish FILE=文章.md           发布草稿"
	@echo "  make delete FILE=文章.md            删除文章"
	@echo "  make edit FILE=文章.md              编辑文章"
	@echo "  make rename FILE=旧名 NEWNAME=新名  重命名文章"
	@echo "  make backup                         备份所有文章"
	@echo ""
	@echo "🔒 文章管理 - 加密:"
	@echo "  make encrypt FILE=文章.md           加密文章"
	@echo "  make decrypt FILE=文章.md           解密文章"
	@echo ""
	@echo "📅 文章管理 - 时间:"
	@echo "  make set-date FILE=文章 DATE=日期   修改发布时间"
	@echo "  make set-updated FILE=文章 [DATE=]  设置更新时间"
	@echo ""
	@echo "🏷️ 文章管理 - 分类标签:"
	@echo "  make set-category FILE= CATEGORY=   设置分类"
	@echo "  make add-tag FILE= TAG=标签         添加标签"
	@echo ""
	@echo "🔧 开发相关:"
	@echo "  make dev                            启动开发服务器"
	@echo "  make build                          构建生产版本"
	@echo "  make preview                        预览生产版本"
	@echo ""
	@echo "🚀 部署相关:"
	@echo "  make deploy MSG=\"提交信息\"          GitHub Pages 部署"
	@echo "  make quick-deploy                   一键部署 (自动提交信息)"
	@echo "  make deploy-vercel                  Vercel 部署"
	@echo "  make deploy-docker                  Docker 容器部署"
	@echo "  make deploy-podman                  Podman 容器部署"
	@echo ""
	@echo "📊 追踪相关:"
	@echo "  make track                          追踪文章变更 (Git)"
	@echo "  make status                         查看 Git 状态"
	@echo "  make log                            查看提交记录"
	@echo ""
	@echo "� 提示: 使用 'make guide' 查看完整用户引导"
	@echo ""

# ===================================================================
# 📝 文章管理
# ===================================================================

# 创建新文章
article:
ifndef TITLE
	@echo "❌ 错误: 请指定文章标题"
	@echo "用法: make article TITLE=\"文章标题\""
	@exit 1
endif
	@echo "📝 创建新文章: $(TITLE)"
	@pnpm new-post "$(TITLE)"
	@echo "✅ 文章创建成功！"
	@echo "📁 位置: src/content/posts/$(TITLE).md"

# 创建草稿
draft:
ifndef TITLE
	@echo "❌ 错误: 请指定草稿标题"
	@echo "用法: make draft TITLE=\"草稿标题\""
	@exit 1
endif
	@echo "📝 创建草稿: $(TITLE)"
	@pnpm new-post "$(TITLE)"
	@sed -i 's/draft: false/draft: true/' src/content/posts/$(TITLE).md
	@echo "✅ 草稿创建成功！"
	@echo "📁 位置: src/content/posts/$(TITLE).md"

# 发布草稿
publish:
ifndef FILE
	@echo "❌ 错误: 请指定文件名"
	@echo "用法: make publish FILE=文章文件名.md"
	@exit 1
endif
	@if [ ! -f "src/content/posts/$(FILE)" ]; then \
		echo "❌ 错误: 文件 src/content/posts/$(FILE) 不存在"; \
		exit 1; \
	fi
	@sed -i 's/draft: true/draft: false/' src/content/posts/$(FILE)
	@echo "✅ 草稿已发布: $(FILE)"

# 列出所有文章
list:
	@echo "📚 文章列表:"
	@echo ""
	@echo "状态      | 标题                          | 文件名                    | 发布日期     | Git状态"
	@echo "----------|-------------------------------|---------------------------|--------------|--------"
	@find src/content/posts -name "*.md" -type f 2>/dev/null | while read file; do \
		title=$$(grep -m 1 "^title:" "$$file" 2>/dev/null | sed 's/title: *//; s/^"//; s/"$$//'); \
		draft=$$(grep -m 1 "^draft:" "$$file" 2>/dev/null | sed 's/draft: *//'); \
		published=$$(grep -m 1 "^published:" "$$file" 2>/dev/null | sed 's/published: *//'); \
		encrypted=$$(grep -m 1 "^encrypted:" "$$file" 2>/dev/null | sed 's/encrypted: *//'); \
		filename=$$(basename "$$file"); \
		status="✅ 已发布"; \
		if [ "$$draft" = "true" ]; then status="📝 草稿  "; fi; \
		if [ "$$encrypted" = "true" ]; then status="🔒 加密  "; fi; \
		git_status=$$(git status --short "$$file" 2>/dev/null | cut -c1-2 || echo "  "); \
		if [ -z "$$git_status" ] || [ "$$git_status" = "  " ]; then git_status="✓"; \
		elif echo "$$git_status" | grep -q "M"; then git_status="M 修改"; \
		elif echo "$$git_status" | grep -q "A"; then git_status="A 新增"; \
		elif echo "$$git_status" | grep -q "?"; then git_status="? 未追踪"; \
		fi; \
		printf "%-9s | %-29s | %-25s | %-12s | %s\n" "$$status" "$$title" "$$filename" "$$published" "$$git_status"; \
	done | sort -t'|' -k4 -r

# 追踪文章变更（显示详细 git 信息）
track:
	@echo "📊 文章变更追踪:"
	@echo ""
	@echo "═══════════════════════════════════════════════════════════════"
	@echo "📁 文章目录: src/content/posts/"
	@echo ""
	@total=$$(find src/content/posts -name "*.md" -type f | wc -l); \
	modified=$$(git status --short src/content/posts 2>/dev/null | grep "^ M" | wc -l); \
	added=$$(git status --short src/content/posts 2>/dev/null | grep "^A" | wc -l); \
	untracked=$$(git status --short src/content/posts 2>/dev/null | grep "^?" | wc -l); \
	echo "📝 总文章数: $$total"; \
	echo "📊 修改中: $$modified | 新增: $$added | 未追踪: $$untracked"
	@echo ""
	@echo "═══════════════════════════════════════════════════════════════"
	@echo "📜 最近修改的文章 (Git 日志):"
	@echo ""
	@git log --oneline --name-only -5 -- src/content/posts/*.md 2>/dev/null | head -20 || echo "暂无 Git 记录"
	@echo ""
	@echo "═══════════════════════════════════════════════════════════════"
	@echo "📝 待提交的文章变更:"
	@git status --short src/content/posts 2>/dev/null || echo "无变更"

# 删除文章
delete:
ifndef FILE
	@echo "❌ 错误: 请指定文件名"
	@echo "用法: make delete FILE=文章文件名.md"
	@exit 1
endif
	@if [ ! -f "src/content/posts/$(FILE)" ]; then \
		echo "❌ 错误: 文件 src/content/posts/$(FILE) 不存在"; \
		exit 1; \
	fi
	@title=$$(grep -m 1 "^title:" "src/content/posts/$(FILE)" | sed 's/title: *//'); \
	echo "⚠️  即将删除文章: $$title ($(FILE))"; \
	read -p "❓ 确认删除? [y/N] " confirm && [ "$$confirm" = "y" ] || exit 1
	@rm "src/content/posts/$(FILE)"
	@echo "✅ 文章已删除: $(FILE)"

# 加密文章（设置 encrypted: true）
encrypt:
ifndef FILE
	@echo "❌ 错误: 请指定文件名"
	@echo "用法: make encrypt FILE=文章文件名.md"
	@exit 1
endif
	@if [ ! -f "src/content/posts/$(FILE)" ]; then \
		echo "❌ 错误: 文件 src/content/posts/$(FILE) 不存在"; \
		exit 1; \
	fi
	@if grep -q "^encrypted:" "src/content/posts/$(FILE)"; then \
		sed -i 's/encrypted: false/encrypted: true/' "src/content/posts/$(FILE)"; \
	else \
		sed -i '/^draft:/a encrypted: true' "src/content/posts/$(FILE)"; \
	fi
	@echo "🔒 文章已加密: $(FILE)"

# 解密文章（设置 encrypted: false）
decrypt:
ifndef FILE
	@echo "❌ 错误: 请指定文件名"
	@echo "用法: make decrypt FILE=文章文件名.md"
	@exit 1
endif
	@if [ ! -f "src/content/posts/$(FILE)" ]; then \
		echo "❌ 错误: 文件 src/content/posts/$(FILE) 不存在"; \
		exit 1; \
	fi
	@sed -i 's/encrypted: true/encrypted: false/' "src/content/posts/$(FILE)"
	@echo "🔓 文章已解密: $(FILE)"

# 修改文章发布时间
set-date:
ifndef FILE
	@echo "❌ 错误: 请指定文件名"
	@echo "用法: make set-date FILE=文章.md DATE=2026-01-26"
	@exit 1
endif
ifndef DATE
	@echo "❌ 错误: 请指定日期"
	@echo "用法: make set-date FILE=文章.md DATE=2026-01-26"
	@exit 1
endif
	@if [ ! -f "src/content/posts/$(FILE)" ]; then \
		echo "❌ 错误: 文件 src/content/posts/$(FILE) 不存在"; \
		exit 1; \
	fi
	@sed -i "s/^published: .*/published: $(DATE)/" "src/content/posts/$(FILE)"
	@echo "📅 发布时间已更新为: $(DATE)"

# 设置更新时间
set-updated:
ifndef FILE
	@echo "❌ 错误: 请指定文件名"
	@echo "用法: make set-updated FILE=文章.md [DATE=2026-01-26]"
	@exit 1
endif
	@if [ ! -f "src/content/posts/$(FILE)" ]; then \
		echo "❌ 错误: 文件 src/content/posts/$(FILE) 不存在"; \
		exit 1; \
	fi
	@date_value=$${DATE:-$$(date +%Y-%m-%d)}; \
	if grep -q "^updated:" "src/content/posts/$(FILE)"; then \
		sed -i "s/^updated: .*/updated: $$date_value/" "src/content/posts/$(FILE)"; \
	else \
		sed -i "/^published:/a updated: $$date_value" "src/content/posts/$(FILE)"; \
	fi; \
	echo "📅 更新时间已设置为: $$date_value"

# 搜索文章
search:
ifndef KEYWORD
	@echo "❌ 错误: 请指定搜索关键词"
	@echo "用法: make search KEYWORD=\"关键词\""
	@exit 1
endif
	@echo "🔍 搜索: $(KEYWORD)"
	@echo ""
	@grep -rl "$(KEYWORD)" src/content/posts --include="*.md" 2>/dev/null | while read file; do \
		title=$$(grep -m 1 "^title:" "$$file" | sed 's/title: *//'); \
		filename=$$(basename "$$file"); \
		echo "📄 $$title ($$filename)"; \
	done || echo "未找到匹配的文章"

# 编辑文章（使用默认编辑器）
edit:
ifndef FILE
	@echo "❌ 错误: 请指定文件名"
	@echo "用法: make edit FILE=文章文件名.md"
	@exit 1
endif
	@if [ ! -f "src/content/posts/$(FILE)" ]; then \
		echo "❌ 错误: 文件 src/content/posts/$(FILE) 不存在"; \
		exit 1; \
	fi
	@$${EDITOR:-code} "src/content/posts/$(FILE)"

# 重命名文章文件
rename:
ifndef FILE
	@echo "❌ 错误: 请指定原文件名"
	@echo "用法: make rename FILE=旧名.md NEWNAME=新名.md"
	@exit 1
endif
ifndef NEWNAME
	@echo "❌ 错误: 请指定新文件名"
	@echo "用法: make rename FILE=旧名.md NEWNAME=新名.md"
	@exit 1
endif
	@if [ ! -f "src/content/posts/$(FILE)" ]; then \
		echo "❌ 错误: 文件 src/content/posts/$(FILE) 不存在"; \
		exit 1; \
	fi
	@mv "src/content/posts/$(FILE)" "src/content/posts/$(NEWNAME)"
	@echo "✅ 文章已重命名: $(FILE) → $(NEWNAME)"

# 设置文章分类
set-category:
ifndef FILE
	@echo "❌ 错误: 请指定文件名"
	@echo "用法: make set-category FILE=文章.md CATEGORY=技术"
	@exit 1
endif
ifndef CATEGORY
	@echo "❌ 错误: 请指定分类"
	@echo "用法: make set-category FILE=文章.md CATEGORY=技术"
	@exit 1
endif
	@if [ ! -f "src/content/posts/$(FILE)" ]; then \
		echo "❌ 错误: 文件 src/content/posts/$(FILE) 不存在"; \
		exit 1; \
	fi
	@sed -i "s/^category: .*/category: '$(CATEGORY)'/" "src/content/posts/$(FILE)"
	@echo "📂 分类已设置为: $(CATEGORY)"

# 添加标签
add-tag:
ifndef FILE
	@echo "❌ 错误: 请指定文件名"
	@echo "用法: make add-tag FILE=文章.md TAG=新标签"
	@exit 1
endif
ifndef TAG
	@echo "❌ 错误: 请指定标签"
	@echo "用法: make add-tag FILE=文章.md TAG=新标签"
	@exit 1
endif
	@if [ ! -f "src/content/posts/$(FILE)" ]; then \
		echo "❌ 错误: 文件 src/content/posts/$(FILE) 不存在"; \
		exit 1; \
	fi
	@current_tags=$$(grep -m 1 "^tags:" "src/content/posts/$(FILE)" | sed 's/tags: *//; s/\[//; s/\]//'); \
	if [ -z "$$current_tags" ]; then \
		sed -i "s/^tags: .*/tags: [$(TAG)]/" "src/content/posts/$(FILE)"; \
	else \
		sed -i "s/^tags: \[/tags: [$(TAG), /" "src/content/posts/$(FILE)"; \
	fi
	@echo "🏷️  标签已添加: $(TAG)"

# 备份所有文章
backup:
	@backup_dir="backups/$$(date +%Y%m%d_%H%M%S)"; \
	mkdir -p "$$backup_dir"; \
	cp -r src/content/posts "$$backup_dir/"; \
	echo "✅ 文章已备份到: $$backup_dir"

# 查看文章详情
info:
ifndef FILE
	@echo "❌ 错误: 请指定文件名"
	@echo "用法: make info FILE=文章文件名.md"
	@exit 1
endif
	@if [ ! -f "src/content/posts/$(FILE)" ]; then \
		echo "❌ 错误: 文件 src/content/posts/$(FILE) 不存在"; \
		exit 1; \
	fi
	@echo "📄 文章详情: $(FILE)"
	@echo "═══════════════════════════════════════"
	@echo "标题:     $$(grep -m 1 '^title:' 'src/content/posts/$(FILE)' | sed 's/title: *//')"
	@echo "发布日期: $$(grep -m 1 '^published:' 'src/content/posts/$(FILE)' | sed 's/published: *//')"
	@echo "更新日期: $$(grep -m 1 '^updated:' 'src/content/posts/$(FILE)' | sed 's/updated: *//' || echo '未设置')"
	@echo "分类:     $$(grep -m 1 '^category:' 'src/content/posts/$(FILE)' | sed 's/category: *//')"
	@echo "标签:     $$(grep -m 1 '^tags:' 'src/content/posts/$(FILE)' | sed 's/tags: *//')"
	@echo "草稿:     $$(grep -m 1 '^draft:' 'src/content/posts/$(FILE)' | sed 's/draft: *//')"
	@echo "加密:     $$(grep -m 1 '^encrypted:' 'src/content/posts/$(FILE)' | sed 's/encrypted: *//' || echo 'false')"
	@echo "摘要:     $$(grep -m 1 '^description:' 'src/content/posts/$(FILE)' | sed 's/description: *//')"
	@echo "═══════════════════════════════════════"
	@words=$$(wc -w < "src/content/posts/$(FILE)"); \
	lines=$$(wc -l < "src/content/posts/$(FILE)"); \
	echo "字数: $$words | 行数: $$lines"


# ===================================================================
# 🔧 开发相关
# ===================================================================

# 安装依赖
install:
	@echo "📦 安装依赖..."
	@pnpm install
	@echo "✅ 依赖安装完成！"

# 启动开发服务器
dev:
	@echo "🚀 启动开发服务器..."
	@pnpm dev

# 构建生产版本
build:
	@echo "🔨 构建生产版本..."
	@GITHUB_PAGES=true pnpm build
	@echo "✅ 构建完成！输出目录: dist/"

# 预览生产版本
preview:
	@echo "👀 预览生产版本..."
	@pnpm preview

# 代码检查
check:
	@echo "🔍 运行代码检查..."
	@pnpm check
	@pnpm lint
	@echo "✅ 检查完成！"

# 格式化代码
format:
	@echo "✨ 格式化代码..."
	@pnpm format
	@echo "✅ 格式化完成！"

# 清理构建文件
clean:
	@echo "🧹 清理构建文件..."
	@rm -rf dist .astro node_modules/.astro
	@echo "✅ 清理完成！"

# ===================================================================
# 🚀 部署相关
# ===================================================================

# 完整部署流程：构建 + 推送源码 + 触发 GitHub Actions
deploy:
ifndef MSG
	@echo "❌ 错误: 请提供提交信息"
	@echo "用法: make deploy MSG=\"提交信息\""
	@exit 1
endif
	@echo "🚀 开始部署流程..."
	@echo ""
	@echo "📊 检查 Git 状态..."
	@git status --short
	@echo ""
	@read -p "❓ 确认要提交并部署吗? [y/N] " confirm && [ "$$confirm" = "y" ] || exit 1
	@echo ""
	@echo "📝 添加所有更改..."
	@git add -A
	@echo "💾 提交更改: $(MSG)"
	@git commit -m "$(MSG)" || echo "⚠️  没有新的更改需要提交"
	@echo "📤 推送到远程仓库..."
	@git push origin main
	@echo ""
	@echo "✅ 部署完成！"
	@echo "🌐 GitHub Actions 将自动构建并部署"
	@echo "📍 查看部署状态: https://github.com/$$(git remote get-url origin | sed 's/.*:\(.*\)\.git/\1/')/actions"

# 一键部署（自动生成提交信息）
quick-deploy:
	@echo "🚀 一键部署流程..."
	@echo ""
	@echo "📊 检查 Git 状态..."
	@git status --short
	@echo ""
	@changes=$$(git status --short | wc -l); \
	if [ "$$changes" -eq 0 ]; then \
		echo "⚠️  没有任何更改需要提交"; \
		exit 0; \
	fi
	@echo "📝 添加所有更改..."
	@git add -A
	@msg="chore: 更新于 $$(date '+%Y-%m-%d %H:%M')"; \
	echo "💾 提交更改: $$msg"; \
	git commit -m "$$msg" || echo "⚠️  没有新的更改需要提交"
	@echo "📤 推送到远程仓库..."
	@git push origin main
	@echo ""
	@echo "✅ 一键部署完成！"
	@echo "🌐 GitHub Actions 将自动构建并部署"
	@echo "📍 查看部署状态: https://github.com/$$(git remote get-url origin | sed 's/.*:\(.*\)\.git/\1/')/actions"

# 仅推送源码（不触发自动部署 - 需要禁用工作流）
push:
ifndef MSG
	@echo "❌ 错误: 请提供提交信息"
	@echo "用法: make push MSG=\"提交信息\""
	@exit 1
endif
	@echo "📝 推送源码（不触发部署）..."
	@echo ""
	@echo "⚠️  注意: 此操作会推送到 main 分支，仍会触发 GitHub Actions"
	@echo "⚠️  如需真正避免自动部署，请考虑："
	@echo "   1. 推送到其他分支: git push origin HEAD:dev"
	@echo "   2. 或暂时禁用 .github/workflows/deploy.yml"
	@echo ""
	@read -p "❓ 继续推送吗? [y/N] " confirm && [ "$$confirm" = "y" ] || exit 1
	@git add -A
	@git commit -m "$(MSG)" || echo "⚠️  没有新的更改需要提交"
	@git push origin main
	@echo "✅ 源码已推送！"

# 仅本地构建
deploy-only:
	@echo "🔨 构建静态站点..."
	@GITHUB_PAGES=true pnpm build
	@echo ""
	@echo "✅ 构建完成！"
	@echo "📁 输出目录: dist/"
	@echo ""
	@echo "💡 提示: 您可以手动部署 dist/ 目录到任何静态托管服务"

# ===================================================================
# 📊 Git 相关
# ===================================================================

# 查看状态
status:
	@echo "📊 Git 状态:"
	@git status

# 查看提交记录
log:
	@echo "📜 最近的提交记录:"
	@git log --oneline --graph --decorate -10

# 查看更改
diff:
	@echo "📝 未提交的更改:"
	@git diff

# ===================================================================
# 🔧 高级功能
# ===================================================================

# 创建带分类的文章
article-with-category:
ifndef TITLE
	@echo "❌ 错误: 请指定文章标题"
	@exit 1
endif
ifndef CATEGORY
	@echo "❌ 错误: 请指定分类"
	@echo "用法: make article-with-category TITLE=\"标题\" CATEGORY=\"分类\""
	@exit 1
endif
	@echo "📝 创建文章: $(TITLE) (分类: $(CATEGORY))"
	@pnpm new-post "$(TITLE)"
	@sed -i "s/category: ''/category: '$(CATEGORY)'/" src/content/posts/$(TITLE).md
	@echo "✅ 文章创建成功！"

# 批量发布所有草稿
publish-all:
	@echo "📢 发布所有草稿..."
	@find src/content/posts -name "*.md" -type f -exec grep -l "draft: true" {} \; | while read file; do \
		sed -i 's/draft: true/draft: false/' "$$file"; \
		echo "✅ 已发布: $$file"; \
	done
	@echo "✅ 所有草稿已发布！"

# 统计信息
stats:
	@echo "📊 博客统计信息:"
	@echo ""
	@total=$$(find src/content/posts -name "*.md" -type f | wc -l); \
	drafts=$$(grep -r "draft: true" src/content/posts --include="*.md" | wc -l); \
	published=$$((total - drafts)); \
	echo "📝 总文章数: $$total"; \
	echo "✅ 已发布: $$published"; \
	echo "📝 草稿: $$drafts"

# ===================================================================
# 🌐 多平台部署
# ===================================================================

# Vercel 部署
deploy-vercel:
	@echo "🚀 部署到 Vercel..."
	@if ! command -v vercel &> /dev/null; then \
		echo "⚠️  Vercel CLI 未安装，正在安装..."; \
		npm i -g vercel; \
	fi
	@vercel --prod
	@echo "✅ Vercel 部署完成！"

# Docker 部署
deploy-docker:
	@echo "🐳 使用 Docker 构建镜像..."
	@docker build -t twilight-blog:latest .
	@echo ""
	@echo "✅ Docker 镜像构建完成！"
	@echo ""
	@echo "💡 运行容器:"
	@echo "   docker run -d -p 8080:80 twilight-blog:latest"
	@echo ""
	@echo "💡 使用 Docker Compose:"
	@echo "   docker-compose up -d"

# Podman 部署
deploy-podman:
	@echo "🦭 使用 Podman 构建镜像..."
	@podman build -t twilight-blog:latest .
	@echo ""
	@echo "✅ Podman 镜像构建完成！"
	@echo ""
	@echo "💡 运行容器:"
	@echo "   podman run -d -p 8080:80 twilight-blog:latest"

# 服务器部署 (rsync)
deploy-server:
ifndef DEPLOY_SERVER
	@echo "❌ 错误: 请设置服务器地址"
	@echo "用法: DEPLOY_SERVER=user@server.com DEPLOY_PATH=/var/www/blog make deploy-server"
	@exit 1
endif
	@echo "🚀 部署到服务器: $(DEPLOY_SERVER)"
	@echo "📁 目标路径: $(DEPLOY_PATH)"
	@echo ""
	@make build
	@echo ""
	@echo "📤 上传文件..."
	@rsync -avz --delete dist/ $(DEPLOY_SERVER):$(DEPLOY_PATH)
	@echo ""
	@echo "✅ 服务器部署完成！"

# 启用 GitHub Actions 工作流
enable-workflow:
	@echo "🔧 启用 GitHub Actions 工作流..."
	@if [ -f .github/workflows/deploy.yml.example ]; then \
		mv .github/workflows/deploy.yml.example .github/workflows/deploy.yml; \
		echo "✅ deploy.yml 已启用"; \
	else \
		echo "⚠️  deploy.yml.example 不存在或已启用"; \
	fi

# ===================================================================
# 📖 用户引导
# ===================================================================

# 显示用户引导
guide:
	@echo "╔═══════════════════════════════════════════════════════════╗"
	@echo "║         Twilight 博客模板 - 用户引导                      ║"
	@echo "╚═══════════════════════════════════════════════════════════╝"
	@echo ""
	@echo "📋 首次使用步骤:"
	@echo "  1. 修改 twilight.config.yaml 配置个人信息"
	@echo "  2. 替换 public/assets/images/avatar.jpg 头像"
	@echo "  3. 删除 src/content/posts/ 下的示例文章"
	@echo "  4. 编辑 src/content/about/index.md 关于页面"
	@echo ""
	@echo "✏️  可修改的文件:"
	@echo "  • twilight.config.yaml  - 站点配置（必改）"
	@echo "  • .env                  - 环境变量（CMS/统计）"
	@echo "  • src/content/          - 所有内容"
	@echo "  • public/assets/        - 静态资源"
	@echo ""
	@echo "🗑️  可删除的文件/目录:"
	@echo "  • src/content/posts/*   - 示例文章"
	@echo "  • docs/image/           - 文档截图"
	@echo "  • astro-theme-retypeset/- 原主题参考"
	@echo ""
	@echo "⚠️  不建议修改:"
	@echo "  • src/components/       - 组件源码"
	@echo "  • src/layouts/          - 布局模板"
	@echo "  • astro.config.mjs      - Astro 配置"
	@echo ""
	@echo "🚀 部署方式:"
	@echo "  make deploy             - GitHub Pages (自动)"
	@echo "  make deploy-vercel      - Vercel"
	@echo "  make deploy-docker      - Docker 容器"
	@echo "  make deploy-podman      - Podman 容器"
	@echo "  make deploy-server      - 服务器 (rsync)"
	@echo ""
	@echo "📚 更多信息请查看 docs/ 目录"

# 清理模板（用于发布自己的博客）
clean-template:
	@echo "🧹 清理模板文件..."
	@read -p "❓ 确认删除示例文章和文档截图? [y/N] " confirm && [ "$$confirm" = "y" ] || exit 1
	@rm -rf src/content/posts/*
	@rm -rf docs/image/
	@rm -rf astro-theme-retypeset/ 2>/dev/null || true
	@echo "✅ 模板清理完成！"
	@echo "💡 现在可以开始创建自己的文章了: make article TITLE=\"我的第一篇\""

# 首次设置向导
setup:
	@echo "╔═══════════════════════════════════════════════════════════╗"
	@echo "║         Twilight 博客 - 首次设置向导                      ║"
	@echo "╚═══════════════════════════════════════════════════════════╝"
	@echo ""
	@echo "📦 步骤 1: 安装依赖..."
	@pnpm install
	@echo ""
	@echo "✅ 依赖安装完成！"
	@echo ""
	@echo "📋 接下来请完成以下步骤:"
	@echo "  1. 编辑 twilight.config.yaml 配置你的信息"
	@echo "  2. 运行 make dev 启动开发服务器"
	@echo "  3. 运行 make guide 查看更多帮助"
	@echo ""
	@echo "🚀 准备好后运行: make dev"

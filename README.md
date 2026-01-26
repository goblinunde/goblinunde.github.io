<div align="center">

# Twilight-retypeset

🌅 A beautiful, feature-rich static blog template built with Astro framework

Combining the design aesthetics of Twilight with the functional architecture of astro-theme-retypeset

[**🖥️ Live Demo**](https://twilight.spr-aachen.com) | [**📝 Documentation**](https://docs.twilight.spr-aachen.com/en)

[![GitHub Stars](https://img.shields.io/github/stars/goblinunde/Twilight-retypeset?style=flat-square)](https://github.com/goblinunde/Twilight-retypeset)

</div>

---

<div align="center">

English | [**中文**](docs/README_ZH.md)

</div>

---

## Table of Contents

- [✨ Features](#-features)
- [📁 Project Structure](#-project-structure)
- [🔧 Component Reference](#-component-reference)
- [📄 Page Reference](#-page-reference)
- [🎨 Style Reference](#-style-reference)
- [⚙️ Configuration Reference](#️-configuration-reference)
- [🚀 Quick Start](#-quick-start)
- [📝 Content Management](#-content-management)
- [🌐 Deployment Guide](#-deployment-guide)
- [⚡ Command Reference](#-command-reference)
- [🎨 Customization](#-customization)

---

## ✨ Features

| Category | Feature | Description |
|----------|---------|-------------|
| **Content** | CMS Integration | Online content management with Decap CMS |
| | Markdown | Full MD/MDX support with syntax highlighting |
| | LaTeX | Mathematical formulas with KaTeX |
| **Visual** | Dynamic Wallpaper | Multi-image carousel with Ken Burns effect |
| | Particle System | Customizable floating particle animations |
| | Transitions | Polished page transition effects |
| **Components** | Music Player | NetEase Cloud API + local music |
| | Reading Mode | Press F for immersive reading |
| | Live2D | Interactive PIO character |
| **Compatibility** | Responsive | Perfect desktop/mobile adaptation |
| | Multi-language | Built-in translation |

---

## 📁 Project Structure

```
Twilight-retypeset/
├── 📁 .github/                  # GitHub configuration
│   └── workflows/               # CI/CD workflows
│       └── deploy.yml.example   # GitHub Pages deployment template
├── 📁 docs/                     # Documentation
├── 📁 public/                   # Static assets (copied directly to output)
│   ├── assets/
│   │   ├── images/              # Image assets
│   │   │   ├── avatar.jpg       # Avatar ← Must replace
│   │   │   ├── wallpaper*.jpg   # Wallpaper images
│   │   │   └── covers/          # Article covers
│   │   └── music/               # Local music files
│   ├── favicon/                 # Site icons
│   └── pio/                     # Live2D model files
├── 📁 src/                      # Source code
│   ├── 📁 components/           # UI components (see details below)
│   ├── 📁 content/              # Content files
│   │   ├── posts/               # Blog articles ← Main editing area
│   │   ├── about/               # About page
│   │   ├── friends/             # Link collection
│   │   ├── projects/            # Project showcase
│   │   ├── skills/              # Skills display
│   │   ├── albums/              # Photo albums
│   │   ├── diary/               # Diary/Status updates
│   │   └── timeline/            # Timeline
│   ├── 📁 layouts/              # Page layout templates
│   ├── 📁 pages/                # Route pages
│   ├── 📁 styles/               # CSS style files
│   ├── 📁 utils/                # Utility functions
│   ├── 📁 plugins/              # Astro plugins
│   ├── 📁 i18n/                 # Multi-language translations
│   └── 📁 constants/            # Constant definitions
├── 📄 twilight.config.yaml      # Main config file ← Must modify
├── 📄 Makefile                  # Build and deploy scripts
├── 📄 package.json              # Dependencies
└── 📄 astro.config.mjs          # Astro framework config
```

### File Modification Guide

| File Type | Modifiable | Description |
|-----------|:----------:|-------------|
| `src/content/**` | ✅ Encouraged | All content files, your blog core |
| `public/assets/**` | ✅ Encouraged | Static assets, replace with yours |
| `twilight.config.yaml` | ✅ Required | Site config, personal info |
| `.env` | ✅ As needed | API key configuration |
| `src/styles/extension.css` | ✅ Encouraged | Custom style extension |
| `src/components/**` | ⚠️ Advanced | UI component source |
| `src/layouts/**` | ⚠️ Advanced | Layout templates |
| `astro.config.mjs` | ❌ Not recommended | Core framework config |

---

## 🔧 Component Reference

### Core Components (`src/components/`)

| File | Function | Modification Effect |
|------|----------|---------------------|
| `navbar.astro` | Top navigation bar | Modify nav item styles, layout |
| `sidebar.astro` | Sidebar container | Adjust sidebar display logic |
| `banner.astro` | Homepage banner area | Modify title animation, typewriter |
| `footer.astro` | Footer | Add license info, copyright |
| `musicPlayer.svelte` | Music player | Customize player style, lyrics |
| `FullscreenReading.svelte` | Fullscreen reading mode | Adjust reading mode style, progress bar |
| `ReadingProgress.svelte` | Reading progress bar | Modify progress bar color, position |
| `pio.svelte` | Live2D character | Configure model path, dialog |
| `loadingOverlay.astro` | Loading animation | Customize loading screen |
| `fullscreenWallpaper.astro` | Fullscreen wallpaper | Adjust wallpaper opacity, blur |
| `pagination.astro` | Pagination component | Modify pagination style |
| `back2TopButton.astro` | Back to top button | Adjust button position, style |
| `tocButton.astro` | Table of contents button | Modify TOC floating button |

### Component Subdirectories

| Directory | Content | Description |
|-----------|---------|-------------|
| `components/navbar/` | Navbar subcomponents | Nav menu, dropdown menu |
| `components/sidebar/` | Sidebar components | Profile, tag cloud, categories |
| `components/post/` | Post-related components | TOC, copyright, navigation |
| `components/common/` | Common components | Markdown rendering, buttons |

---

## 📄 Page Reference

### Route Pages (`src/pages/`)

| File | URL Path | Description |
|------|----------|-------------|
| `[...page].astro` | `/` `/page/2` | Homepage article list, pagination |
| `archive.astro` | `/archive/` | Article archive page |
| `about.astro` | `/about/` | About page |
| `friends.astro` | `/friends/` | Link collection page |
| `projects.astro` | `/projects/` | Project showcase page |
| `skills.astro` | `/skills/` | Skills display page |
| `timeline.astro` | `/timeline/` | Timeline page |
| `diary.astro` | `/diary/` | Diary/Status page |
| `albums.astro` | `/albums/` | Album list page |
| `anime.astro` | `/anime/` | Anime tracking (Bangumi) |
| `rss.astro` | `/rss/` | RSS subscription page |
| `atom.astro` | `/atom/` | Atom subscription page |
| `404.astro` | `/404` | 404 error page |
| `posts/[...slug].astro` | `/posts/xxx/` | Article detail page |

---

## 🎨 Style Reference

### CSS Files (`src/styles/`)

| File | Description | Modification Effect |
|------|-------------|---------------------|
| `main.css` | Main entry, global styles | Modify global fonts, colors |
| `variables.styl` | CSS variable definitions | Modify theme colors, spacing, radius |
| `extension.css` | **User extension styles** ← Recommended | Add custom styles (update-safe) |
| `grid.css` | Grid layout styles | Adjust page grid layout |
| `navbar.css` | Navbar styles | Modify navbar color, height |
| `banner.css` | Banner area styles | Adjust banner height, text styles |
| `markdown.css` | Markdown rendering styles | Modify article typography |
| `transition.css` | Transition animations | Adjust page switch animations |
| `musicplayer.css` | Music player styles | Customize player appearance |
| `twikoo.css` | Comment section styles | Customize comment area |
| `katex-enhance.css` | Math formula styles | Adjust formula display |
| `heti.css` | CJK typography optimization | Optimize Chinese display |

---

## ⚙️ Configuration Reference

### twilight.config.yaml (Main Config)

```yaml
# === Site Basic Config ===
site:
  siteURL: "https://yourdomain.com/"     # Site URL (must end with /)
  title: "Blog Title"                     # Site title
  subtitle: "Subtitle"                    # Subtitle
  lang: "en"                              # Language: en / zh / ja
  
  # Theme color config
  themeColor:
    hue: 255                              # Hue value 0-360
                                          # Red:0 Orange:30 Yellow:60 Green:120 
                                          # Cyan:180 Blue:225 Purple:270 Pink:345
  defaultTheme: "dark"                    # Default: system/light/dark
  
  # Wallpaper config
  wallpaper:
    mode: "banner"                        # banner/fullscreen/none
    src:
      desktop:
        - "/assets/images/wallpaper1.jpg"
        - "/assets/images/wallpaper2.jpg"
      mobile:
        - "/assets/images/mobile1.jpg"
    carousel:
      enable: true                        # Enable carousel
      interval: 3.6                       # Interval (seconds)
      kenBurns: true                      # Ken Burns effect

# === Navbar Config ===
navbar:
  links:
    - "Home"                              # Preset link
    - "Archive"
    - name: "Exhibition"                  # Custom dropdown
      children:
        - "Projects"
        - "Skills"
    - "Friends"
    - "About"

# === Profile Config ===
profile:
  avatar: "/assets/images/avatar.jpg"     # Avatar path
  name: "Your Name"                       # Display name
  bio: "Your bio"                         # One-line bio
  links:                                   # Social links
    - name: "GitHub"
      icon: "fa6-brands:github"
      url: "https://github.com/username"

# === Post Config ===
post:
  showLastModified: true                  # Show update time
  license:
    enable: true
    name: "CC BY-NC-SA 4.0"
  comment:
    enable: false                         # Enable comments
    twikoo:
      envId: "https://your-twikoo.com"

# === Music Player Config ===
musicPlayer:
  enable: true
  mode: "meting"                          # meting / local
  meting:
    server: "netease"                     # NetEase Cloud
    type: "playlist"                      # Playlist
    id: "2161912966"                      # Playlist ID
```

---

## 🚀 Quick Start

### Step 1: Clone Repository

```bash
git clone https://github.com/goblinunde/Twilight-retypeset.git
cd Twilight-retypeset
```

### Step 2: Install Dependencies

```bash
# Install pnpm if not installed
npm install -g pnpm

# Install dependencies
pnpm install

# Or use Makefile
make setup
```

### Step 3: Configure Blog

1. **Edit `twilight.config.yaml`**: Modify site title, personal info
2. **Replace avatar**: `public/assets/images/avatar.jpg`
3. **Replace wallpapers**: `public/assets/images/wallpaper*.jpg`
4. **Delete sample posts**: `rm -rf src/content/posts/*` or `make clean-template`
5. **Edit about page**: `src/content/about/index.md`

### Step 4: Local Preview

```bash
pnpm dev
# or
make dev
```

Visit `http://localhost:4321`

---

## 📝 Content Management

### Creating Posts

```bash
# Create new post
make article TITLE="Post Title"

# Create draft (not published)
make draft TITLE="Draft Title"
```

### Post Format

```yaml
---
title: "Post Title"
published: 2026-01-26
updated: 2026-01-26
category: "Tutorial"
tags: [Astro, Blog, Tutorial]
description: "Post summary for SEO and preview"
image: "/assets/images/cover.jpg"    # Optional cover
draft: false                          # true = draft
encrypted: false                      # true = encrypted post
---

# Content

Supports **Markdown** syntax...
```

### Post Management Commands

| Command | Description |
|---------|-------------|
| `make list` | List all posts (with Git status) |
| `make track` | Track post Git change history |
| `make info FILE=xxx.md` | View post details |
| `make search KEYWORD="keyword"` | Search posts |
| `make publish FILE=xxx.md` | Publish draft |
| `make delete FILE=xxx.md` | Delete post |
| `make encrypt FILE=xxx.md` | Encrypt post |
| `make backup` | Backup all posts |
| `make stats` | Blog statistics |

---

## 🌐 Deployment Guide

### Option 1: GitHub Pages (Recommended)

#### Step 1: Enable Workflow

```bash
# Copy workflow config
mv .github/workflows/deploy.yml.example .github/workflows/deploy.yml

# Or use Makefile
make enable-workflow
```

#### Step 2: Configure Repository

1. Go to GitHub repo → **Settings** → **Pages**
2. Set **Source** to **GitHub Actions**
3. Save settings

#### Step 3: Deploy

```bash
# One-click deploy (auto-generated commit message)
make quick-deploy

# Or with custom message
make deploy MSG="Update blog"
```

#### Step 4: Access

After successful deployment: `https://username.github.io/repo-name/`

**Custom domain:**

1. Create `CNAME` file in `public/` with your domain
2. Configure DNS to point to GitHub Pages

---

### Option 2: Vercel

#### Online Deploy

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new)

#### Manual Configuration

1. Visit [vercel.com](https://vercel.com)
2. Click **Add New** → **Project**
3. Import GitHub repository
4. Configure:
   - Framework Preset: `Astro`
   - Build Command: `pnpm build`
   - Output Directory: `dist`
5. Click **Deploy**

#### CLI Deploy

```bash
make deploy-vercel
```

---

### Option 3: Docker

```bash
# Build image
make deploy-docker

# Run container
docker run -d -p 8080:80 twilight-blog:latest

# Or use Docker Compose
docker-compose up -d
```

Visit `http://localhost:8080`

---

### Option 4: Podman (Fedora Recommended)

```bash
# Build image
make deploy-podman

# Run container
podman run -d -p 8080:80 twilight-blog:latest

# Auto-start service
podman generate systemd --new --name twilight-blog > ~/.config/systemd/user/twilight-blog.service
systemctl --user enable --now twilight-blog
```

---

### Option 5: Traditional Server

```bash
# 1. Build static files
make build

# 2. Upload to server
rsync -avz --delete dist/ user@server:/var/www/blog/

# Or use Makefile
DEPLOY_SERVER=user@server DEPLOY_PATH=/var/www/blog make deploy-server
```

**Nginx Configuration:**

```nginx
server {
    listen 80;
    server_name blog.yourdomain.com;
    root /var/www/blog;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff2?)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    gzip on;
    gzip_types text/plain text/css application/json application/javascript;
}
```

---

## ⚡ Command Reference

### Makefile Commands

| Command | Description |
|---------|-------------|
| `make help` | Show all command help |
| `make setup` | First-time setup wizard |
| `make dev` | Start development server |
| `make build` | Build for production |
| `make preview` | Preview production build |
| `make deploy MSG="..."` | Deploy to GitHub Pages |
| `make quick-deploy` | One-click deploy |
| `make article TITLE="..."` | Create new post |
| `make draft TITLE="..."` | Create draft |
| `make list` | List all posts |
| `make track` | Track post changes |
| `make stats` | Blog statistics |
| `make clean` | Clean build files |
| `make clean-template` | Clean template samples |

### pnpm Commands

| Command | Description |
|---------|-------------|
| `pnpm dev` | Start dev server |
| `pnpm build` | Build site |
| `pnpm preview` | Preview build |
| `pnpm new-post <title>` | Create new post |
| `pnpm lint` | Code check |
| `pnpm format` | Format code |

---

## 🎨 Customization

### Modify Theme Color

Edit `twilight.config.yaml`:

```yaml
site:
  themeColor:
    hue: 255  # Hue value 0-360
```

Hue reference:

- 🔴 Red: 0
- 🟠 Orange: 30
- 🟡 Yellow: 60
- 🟢 Green: 120
- 🔵 Cyan: 180
- 💜 Purple: 270
- 💗 Pink: 345

### Add Custom Styles

Create/edit `src/styles/extension.css`:

```css
/* Custom card style */
.card-base {
    backdrop-filter: blur(12px);
    border: 1px solid rgba(255, 255, 255, 0.1);
}

/* Custom font */
body {
    font-family: "Inter", sans-serif;
}
```

### Add Custom Scripts

Edit `src/layouts/base.astro`, add before `</body>`:

```html
<script>
    // Your custom scripts
</script>
```

---

## 🙏 Acknowledgements

- Prototype - [Fuwari](https://github.com/saicaca/fuwari)
- Inspiration - [Yukina](https://github.com/WhitePaper233/yukina) & [Mizuki](https://github.com/matsuzaka-yuki/Mizuki)
- CMS - [astro-decap-cms-oauth](https://github.com/dorukgezici/astro-decap-cms-oauth)
- Translation - [translate](https://gitee.com/mail_osc/translate)

---

## 📄 License

[MIT License](LICENSE)

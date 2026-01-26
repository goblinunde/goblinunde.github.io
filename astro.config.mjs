import { defineConfig } from "astro/config";
import { pluginCollapsibleSections } from "@expressive-code/plugin-collapsible-sections";
import { pluginLineNumbers } from "@expressive-code/plugin-line-numbers";
import svelte, { vitePreprocess } from "@astrojs/svelte";
import tailwind from "@astrojs/tailwind";
import swup from "@swup/astro";
import sitemap from "@astrojs/sitemap";
import vercel from "@astrojs/vercel";
import cloudflarePages from "@astrojs/cloudflare";
import decapCmsOauth from "astro-decap-cms-oauth";
import expressiveCode from "astro-expressive-code";
import icon from "astro-icon";
import rehypeAutolinkHeadings from "rehype-autolink-headings";
import rehypeComponents from "rehype-components"; /* Render the custom directive content */
import rehypeKatex from "rehype-katex";
import rehypeSlug from "rehype-slug";
import remarkDirective from "remark-directive"; /* Handle directives */
import remarkGithubAdmonitionsToDirectives from "remark-github-admonitions-to-directives";
import remarkMath from "remark-math";
import remarkSectionize from "remark-sectionize";

import { siteConfig } from "./src/config.ts";

// 💡 KaTeX 配置优化，提升数学公式渲染质量（适合数学/深度学习博客）
const katexOptions = {
    strict: false,
    trust: true,
    output: "htmlAndMathml", // 更好的可访问性
    macros: {
        // 常用数学集合
        "\\R": "\\mathbb{R}",
        "\\N": "\\mathbb{N}",
        "\\Z": "\\mathbb{Z}",
        "\\C": "\\mathbb{C}",
        "\\Q": "\\mathbb{Q}",
        // 微分算子
        "\\dd": "\\mathrm{d}",
        "\\pdv": "\\frac{\\partial #1}{\\partial #2}",
        "\\dv": "\\frac{\\dd #1}{\\dd #2}",
        // 向量分析
        "\\grad": "\\nabla",
        "\\div": "\\nabla \\cdot",
        "\\curl": "\\nabla \\times",
        "\\laplacian": "\\nabla^2",
        // 深度学习常用
        "\\expect": "\\mathbb{E}",
        "\\var": "\\mathrm{Var}",
        "\\argmax": "\\operatorname{argmax}",
        "\\argmin": "\\operatorname{argmin}",
        "\\softmax": "\\operatorname{softmax}",
        "\\relu": "\\operatorname{ReLU}",
        // 线性代数
        "\\tr": "\\operatorname{tr}",
        "\\diag": "\\operatorname{diag}",
        "\\rank": "\\operatorname{rank}",
    },
};
import { pluginCollapseButton } from "./src/plugins/expressive-code/collapse-button.ts";
import { pluginCopyButton } from "./src/plugins/expressive-code/copy-button.js";
import { pluginLanguageBadge } from "./src/plugins/expressive-code/language-badge.ts";
import { AdmonitionComponent } from "./src/plugins/rehype-component-admonition.mjs";
import { GithubCardComponent } from "./src/plugins/rehype-component-github-card.mjs";
import { rehypeMermaid } from "./src/plugins/rehype-mermaid.mjs";
import { parseDirectiveNode } from "./src/plugins/remark-directive-rehype.js";
import { remarkExcerpt } from "./src/plugins/remark-excerpt.js";
import { remarkMermaid } from "./src/plugins/remark-mermaid.js";
import { remarkReadingTime } from "./src/plugins/remark-reading-time.mjs";


// https://astro.build/config
// 💡 智能选择部署模式：GitHub Pages / Cloudflare / Vercel
const isGitHubPages = process.env.GITHUB_PAGES === "true";
const adapter = process.env.CF_PAGES ? cloudflarePages() : vercel({ mode: "serverless" });

export default defineConfig({
    site: siteConfig.siteURL,
    base: "/",
    trailingSlash: "always",
    output: isGitHubPages ? "static" : "server",
    adapter: isGitHubPages ? undefined : adapter,
    integrations: [
        decapCmsOauth({
            decapCMSVersion: "3.3.3",
            oauthDisabled: true, // Disable it to use oauth, requires .env configuration
        }),
        tailwind({
            nesting: true,
        }),
        swup({
            theme: false,
            animationClass: "transition-swup-", // see https://swup.js.org/options/#animationselector
            containers: [
                "#swup-container",
                "#left-sidebar",
                "#right-sidebar",
            ],
            cache: true,
            preload: true,
            accessibility: true,
            updateHead: true,
            updateBodyClass: false,
            globalInstance: true,
            // Scroll related configuration optimization
            smoothScrolling: false, // Disable smooth scrolling to improve performance and avoid conflicts with anchor navigation
            resolveUrl: (url) => url,
            animateHistoryBrowsing: false,
            skipPopStateHandling: (event) => {
                // Skip anchor link handling, let the browser handle it natively
                return event.state && event.state.url && event.state.url.includes("#");
            },
        }),
        icon({
            include: {
                "fa6-brands": ["*"],
                "fa6-regular": ["*"],
                "fa6-solid": ["*"],
                mdi: ["*"],
            },
        }),
        expressiveCode({
            themes: ["github-light", "github-dark"],
            themeCSSSelector: (theme) => `[data-theme="${theme}"]`,
            plugins: [
                pluginCollapsibleSections(),
                pluginLineNumbers(),
                pluginCollapseButton(),
                pluginCopyButton(),
                pluginLanguageBadge(),
            ],
            defaultProps: {
                wrap: true,
                overridesByLang: {
                    shellsession: {
                        showLineNumbers: false,
                    },
                },
            },
            styleOverrides: {
                codeBackground: "var(--codeblock-bg)",
                borderRadius: "0.75rem",
                borderColor: "none",
                codeFontSize: "0.875rem",
                codeFontFamily:
                    "'JetBrains Mono Variable', ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, 'Liberation Mono', 'Courier New', monospace",
                codeLineHeight: "1.5rem",
                frames: {
                    editorBackground: "var(--codeblock-bg)",
                    terminalBackground: "var(--codeblock-bg)",
                    terminalTitlebarBackground: "var(--codeblock-bg)",
                    editorTabBarBackground: "var(--codeblock-bg)",
                    editorActiveTabBackground: "none",
                    editorActiveTabIndicatorBottomColor: "var(--primary)",
                    editorActiveTabIndicatorTopColor: "none",
                    editorTabBarBorderBottomColor: "var(--codeblock-bg)",
                    terminalTitlebarBorderBottomColor: "none",
                    copyButtonBackground: "var(--btn-regular-bg)",
                    copyButtonBackgroundHover: "var(--btn-regular-bg-hover)",
                    copyButtonBackgroundActive: "var(--btn-regular-bg-active)",
                    copyButtonForeground: "var(--btn-content)",
                },
                textMarkers: {
                    delHue: 0,
                    insHue: 180,
                    markHue: 250,
                },
            },
            frames: {
                showCopyToClipboardButton: false,
            },
        }),
        svelte({
            preprocess: vitePreprocess(),
        }),
        sitemap(),
    ],
    markdown: {
        remarkPlugins: [
            remarkMath,
            remarkReadingTime,
            remarkExcerpt,
            remarkGithubAdmonitionsToDirectives,
            remarkDirective,
            remarkSectionize,
            parseDirectiveNode,
            remarkMermaid,
        ],
        rehypePlugins: [
            [rehypeKatex, katexOptions],
            rehypeSlug,
            rehypeMermaid,
            [
                rehypeComponents,
                {
                    components: {
                        github: GithubCardComponent,
                        note: (x, y) => AdmonitionComponent(x, y, "note"),
                        tip: (x, y) => AdmonitionComponent(x, y, "tip"),
                        important: (x, y) => AdmonitionComponent(x, y, "important"),
                        caution: (x, y) => AdmonitionComponent(x, y, "caution"),
                        warning: (x, y) => AdmonitionComponent(x, y, "warning"),
                    },
                },
            ],
            [
                rehypeAutolinkHeadings,
                {
                    behavior: "append",
                    properties: {
                        className: ["anchor"],
                    },
                    content: {
                        type: "element",
                        tagName: "span",
                        properties: {
                            className: ["anchor-icon"],
                            "data-pagefind-ignore": true,
                        },
                        children: [
                            {
                                type: "text",
                                value: "#",
                            },
                        ],
                    },
                },
            ],
        ],
    },
    vite: {
        build: {
            rollupOptions: {
                onwarn(warning, warn) {
                    // temporarily suppress this warning
                    if (
                        warning.message.includes("is dynamically imported by") &&
                        warning.message.includes("but also statically imported by")
                    ) {
                        return;
                    }
                    warn(warning);
                },
            },
        },
    },
    build: {
        inlineStylesheets: "always",
    },
});
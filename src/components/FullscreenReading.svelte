<script lang="ts">
import { onMount, onDestroy } from "svelte";
import Icon from "@iconify/svelte";

// 💡 全屏阅读模式状态
let isFullscreen = $state(false);
let progress = $state(0);
let originalStyles: { overflow: string; padding: string } | null = null;
let scrollHandler: (() => void) | null = null;

function updateProgress() {
    const scrollTop = window.scrollY || document.documentElement.scrollTop;
    const scrollHeight = document.documentElement.scrollHeight - window.innerHeight;
    
    if (scrollHeight > 0) {
        progress = Math.min(100, Math.max(0, (scrollTop / scrollHeight) * 100));
    }
}

function toggleFullscreen() {
    const article = document.querySelector(".custom-md, article, .post-content, #post-container");
    const body = document.body;
    
    if (!isFullscreen) {
        // 进入全屏模式
        originalStyles = {
            overflow: body.style.overflow,
            padding: body.style.padding,
        };
        
        body.classList.add("fullscreen-reading");
        isFullscreen = true;
        
        // 开始跟踪阅读进度
        scrollHandler = updateProgress;
        window.addEventListener("scroll", scrollHandler, { passive: true });
        updateProgress();
        
        // 滚动到文章开头
        if (article) {
            article.scrollIntoView({ behavior: "smooth", block: "start" });
        }
    } else {
        // 退出全屏模式
        body.classList.remove("fullscreen-reading");
        isFullscreen = false;
        
        // 停止跟踪阅读进度
        if (scrollHandler) {
            window.removeEventListener("scroll", scrollHandler);
            scrollHandler = null;
        }
    }
}

function handleKeydown(event: KeyboardEvent) {
    // 💡 忽略在输入框中的按键
    const target = event.target as HTMLElement;
    if (target.tagName === "INPUT" || target.tagName === "TEXTAREA" || target.isContentEditable) {
        return;
    }
    
    // F 键进入全屏（仅在文章页面）
    if ((event.key === "f" || event.key === "F") && !isFullscreen) {
        const isPostPage = !!document.querySelector("#post-container, .post-content");
        if (isPostPage) {
            event.preventDefault();
            toggleFullscreen();
        }
    }
    
    // ESC 键退出全屏
    if (event.key === "Escape" && isFullscreen) {
        toggleFullscreen();
    }
}

onMount(() => {
    if (typeof document !== "undefined") {
        document.addEventListener("keydown", handleKeydown);
    }
});

onDestroy(() => {
    // 💡 SSR 安全：仅在客户端执行 DOM 操作
    if (typeof document !== "undefined") {
        document.removeEventListener("keydown", handleKeydown);
        if (scrollHandler) {
            window.removeEventListener("scroll", scrollHandler);
        }
        if (isFullscreen) {
            document.body.classList.remove("fullscreen-reading");
        }
    }
});
</script>

<button
    class="fullscreen-toggle btn-plain w-10 h-10 rounded-lg flex items-center justify-center"
    class:active={isFullscreen}
    onclick={toggleFullscreen}
    title={isFullscreen ? "退出全屏阅读 (ESC)" : "全屏阅读模式 (F)"}
>
    {#if isFullscreen}
        <Icon icon="material-symbols:fullscreen-exit" class="text-lg" />
    {:else}
        <Icon icon="material-symbols:fullscreen" class="text-lg" />
    {/if}
</button>

<!-- 全屏模式下的阅读进度条 -->
{#if isFullscreen}
    <div class="fullscreen-progress-container">
        <div 
            class="fullscreen-progress-bar"
            style="width: {progress}%"
        ></div>
    </div>
{/if}

<style>
    .fullscreen-toggle.active {
        color: var(--primary);
        background: var(--btn-plain-bg-hover);
    }
    
    /* 全屏模式阅读进度条 */
    .fullscreen-progress-container {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        height: 3px;
        background: rgba(0, 0, 0, 0.1);
        z-index: 10001;
        pointer-events: none;
    }
    
    .fullscreen-progress-bar {
        height: 100%;
        background: linear-gradient(
            90deg,
            var(--primary) 0%,
            oklch(0.75 0.18 var(--hue)) 50%,
            var(--primary) 100%
        );
        transition: width 0.1s ease-out;
        box-shadow: 0 0 10px var(--primary);
    }
    
    /* 全局全屏阅读模式样式 */
    :global(body.fullscreen-reading) {
        overflow: auto;
    }
    
    :global(body.fullscreen-reading #navbar),
    :global(body.fullscreen-reading #navbar-wrapper),
    :global(body.fullscreen-reading .sidebar),
    :global(body.fullscreen-reading #sidebar-left),
    :global(body.fullscreen-reading #sidebar-right),
    :global(body.fullscreen-reading #left-sidebar),
    :global(body.fullscreen-reading #right-sidebar),
    :global(body.fullscreen-reading #mobile-sidebar),
    :global(body.fullscreen-reading #banner-wrapper),
    :global(body.fullscreen-reading .music-player),
    :global(body.fullscreen-reading #pio-container),
    :global(body.fullscreen-reading footer),
    :global(body.fullscreen-reading .top-gradient-highlight),
    :global(body.fullscreen-reading .toc-floating-container),
    :global(body.fullscreen-reading #back-to-top-btn) {
        display: none !important;
    }
    
    :global(body.fullscreen-reading #main-grid) {
        display: block !important;
        max-width: 800px !important;
        margin: 0 auto !important;
        padding: 2rem 1rem !important;
    }
    
    :global(body.fullscreen-reading .post-content),
    :global(body.fullscreen-reading article),
    :global(body.fullscreen-reading #post-container) {
        max-width: 100% !important;
    }
    
    :global(body.fullscreen-reading .fullscreen-toggle) {
        position: fixed !important;
        top: 1rem !important;
        right: 1rem !important;
        z-index: 10000 !important;
        background: var(--card-bg) !important;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2) !important;
        border-radius: 0.5rem !important;
    }
    
    /* 全屏模式进入/退出过渡动画 */
    :global(body.fullscreen-reading #main-grid) {
        animation: fadeIn 0.3s ease-out;
    }
    
    @keyframes fadeIn {
        from {
            opacity: 0.8;
            transform: translateY(10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
</style>


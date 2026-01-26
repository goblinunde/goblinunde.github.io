<script lang="ts">
import { onMount, onDestroy } from "svelte";

// 💡 阅读进度百分比
let progress = $state(0);
let scrollHandler: (() => void) | null = null;

function updateProgress() {
    const scrollTop = window.scrollY || document.documentElement.scrollTop;
    const scrollHeight = document.documentElement.scrollHeight - window.innerHeight;
    
    if (scrollHeight > 0) {
        progress = Math.min(100, Math.max(0, (scrollTop / scrollHeight) * 100));
    }
}

onMount(() => {
    scrollHandler = updateProgress;
    window.addEventListener("scroll", scrollHandler, { passive: true });
    updateProgress(); // 初始化
});

onDestroy(() => {
    if (scrollHandler) {
        window.removeEventListener("scroll", scrollHandler);
    }
});
</script>

<div class="reading-progress-container">
    <div 
        class="reading-progress-bar"
        style="width: {progress}%"
    ></div>
</div>

<style>
    .reading-progress-container {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        height: 3px;
        background: transparent;
        z-index: 9999;
        pointer-events: none;
    }
    
    .reading-progress-bar {
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
</style>

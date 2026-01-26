<script lang="ts">
import { onMount } from "svelte";
import Icon from "@iconify/svelte";
import { setHue, getHue } from "@utils/hue";

// 💡 预设主题配置
const THEMES = [
    { id: "twilight", name: "Twilight", hue: 255, icon: "material-symbols:dark-mode" },
    { id: "sakura", name: "Sakura", hue: 345, icon: "material-symbols:local-florist" },
    { id: "forest", name: "Forest", hue: 120, icon: "material-symbols:forest" },
    { id: "sunset", name: "Sunset", hue: 30, icon: "material-symbols:wb-twilight" },
    { id: "ocean", name: "Ocean", hue: 200, icon: "material-symbols:water-drop" },
    { id: "crimson", name: "Crimson", hue: 0, icon: "material-symbols:local-fire-department" },
    { id: "gold", name: "Gold", hue: 45, icon: "material-symbols:star" },
    { id: "mint", name: "Mint", hue: 160, icon: "material-symbols:eco" },
];

const STORAGE_KEY = "theme-preset";

let currentThemeId = $state("twilight");
let isOpen = $state(false);

function getStoredTheme(): string {
    if (typeof localStorage !== "undefined") {
        return localStorage.getItem(STORAGE_KEY) || "twilight";
    }
    return "twilight";
}

function getThemeByHue(hue: number): string {
    // 找到最接近当前 hue 的主题
    const theme = THEMES.find(t => t.hue === hue);
    return theme?.id || "twilight";
}

function applyTheme(themeId: string) {
    const theme = THEMES.find(t => t.id === themeId);
    if (!theme) return;
    
    currentThemeId = themeId;
    
    // 💡 使用现有的 setHue 函数设置主题色
    setHue(theme.hue);
    
    // 保存主题 ID 到 localStorage
    if (typeof localStorage !== "undefined") {
        localStorage.setItem(STORAGE_KEY, themeId);
    }
    
    // 关闭面板
    isOpen = false;
}

function togglePanel() {
    isOpen = !isOpen;
}

function handleClickOutside(event: MouseEvent) {
    const panel = document.getElementById("theme-switcher-panel");
    const button = document.getElementById("theme-switcher-btn");
    if (panel && button && !panel.contains(event.target as Node) && !button.contains(event.target as Node)) {
        isOpen = false;
    }
}

onMount(() => {
    // 恢复保存的主题
    const savedThemeId = getStoredTheme();
    const currentHue = getHue();
    
    // 优先使用保存的主题 ID，否则根据当前 hue 推断
    if (savedThemeId && THEMES.find(t => t.id === savedThemeId)) {
        currentThemeId = savedThemeId;
        // 确保 hue 与主题匹配
        const theme = THEMES.find(t => t.id === savedThemeId);
        if (theme && theme.hue !== currentHue) {
            setHue(theme.hue);
        }
    } else {
        currentThemeId = getThemeByHue(currentHue);
    }
    
    // 监听点击外部关闭
    document.addEventListener("click", handleClickOutside);
    
    return () => {
        document.removeEventListener("click", handleClickOutside);
    };
});
</script>

<div class="theme-switcher relative">
    <!-- 主题切换按钮 -->
    <button
        id="theme-switcher-btn"
        class="btn-plain w-10 h-10 rounded-lg flex items-center justify-center"
        onclick={togglePanel}
        title="切换主题色"
    >
        <Icon icon="material-symbols:palette" class="text-lg" />
    </button>
    
    <!-- 主题选择面板 -->
    {#if isOpen}
        <div
            id="theme-switcher-panel"
            class="absolute top-full right-0 mt-2 p-3 float-panel min-w-[200px] z-50"
        >
            <div class="text-sm text-50 mb-2 px-1">选择主题</div>
            <div class="grid grid-cols-4 gap-2">
                {#each THEMES as theme}
                    <button
                        class="theme-option w-10 h-10 rounded-lg flex items-center justify-center transition-all duration-150 hover:scale-110"
                        class:ring-2={currentThemeId === theme.id}
                        class:ring-[var(--primary)]={currentThemeId === theme.id}
                        style="background-color: oklch(0.65 0.15 {theme.hue})"
                        onclick={() => applyTheme(theme.id)}
                        title={theme.name}
                    >
                        <Icon icon={theme.icon} class="text-white text-lg drop-shadow-sm" />
                    </button>
                {/each}
            </div>
            <div class="text-xs text-30 mt-2 px-1 text-center">
                当前: {THEMES.find(t => t.id === currentThemeId)?.name || "Twilight"}
            </div>
        </div>
    {/if}
</div>

<style>
    .theme-option {
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
    }
    
    .theme-option:hover {
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.25);
    }
</style>

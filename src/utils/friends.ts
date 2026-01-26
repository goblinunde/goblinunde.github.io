// Friends links data configuration file
// Used to manage data for the friends page
const friendModules = import.meta.glob('../content/friends/*.json', { eager: true });

export interface FriendLink {
    id: string;
    title: string;
    imgurl: string;
    desc: string;
    siteurl: string;
    tags?: string[];
    category?: string;
}

// 💡 分类定义
export const categories = {
    journal: { name: '📚 数学期刊', order: 1 },
    preprint: { name: '📄 预印本平台', order: 2 },
    ai: { name: '🤖 AI 公司', order: 3 },
    deeplearning: { name: '🧠 深度学习', order: 4 },
    conference: { name: '🏆 顶级会议', order: 5 },
    tool: { name: '🔧 工具资源', order: 6 },
    other: { name: '🔗 其他链接', order: 99 }
} as const;

export type CategoryKey = keyof typeof categories;

export const friendsData: FriendLink[] = Object.entries(friendModules).map(([path, mod]: [string, any]) => {
    const id = path.split('/').pop()?.replace('.json', '') || '';
    const data = mod.default;
    return { id, ...data } as FriendLink;
});

// 💡 按分类分组链接
export function getGroupedLinks(): Map<string, FriendLink[]> {
    const grouped = new Map<string, FriendLink[]>();

    friendsData.forEach(link => {
        const category = link.category || 'other';
        if (!grouped.has(category)) {
            grouped.set(category, []);
        }
        grouped.get(category)!.push(link);
    });

    // 按分类顺序排序
    const sortedMap = new Map<string, FriendLink[]>();
    const sortedKeys = Array.from(grouped.keys()).sort((a, b) => {
        const orderA = (categories as any)[a]?.order ?? 99;
        const orderB = (categories as any)[b]?.order ?? 99;
        return orderA - orderB;
    });

    sortedKeys.forEach(key => {
        sortedMap.set(key, grouped.get(key)!);
    });

    return sortedMap;
}

// 💡 获取分类显示名称
export function getCategoryName(key: string): string {
    return (categories as any)[key]?.name || key;
}
# Từ điển Hành vi - Trang chủ

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41                        🔍  │
├─────────────────────────────────┤
│                                 │
│  📚 Từ điển Hành vi             │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🔍 Tìm kiếm hành vi...    │ │ Search bar
│  └───────────────────────────┘ │
│                                 │
│  [🏷️ Lọc] [📊 Sắp xếp] [⭐ Yêu thích]│
│                                 │
│  ⭐ Yêu thích của bạn (3)       │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ⚠️ Ném đồ vật          ⭐ │ │
│  │ Aggression • 127× hệ thống│ │
│  │ 12× học sinh của bạn      │ │
│  │ [Xem chi tiết →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🏃 Tự ý rời chỗ        ⭐ │ │
│  │ Avoidance • 98× hệ thống  │ │
│  │ 8× học sinh của bạn       │ │
│  │ [Xem chi tiết →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 📢 La hét              ⭐ │ │
│  │ Attention • 85× hệ thống  │ │
│  │ 5× học sinh của bạn       │ │
│  │ [Xem chi tiết →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  🔥 Xu hướng tuần này           │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 😤 Cáu gắt/Bực bội   ↗️45×│ │
│  │ ┌──────────────────────┐  │ │
│  │ │████████░░ +15%       │  │ │ Trend
│  │ └──────────────────────┘  │ │
│  │ [Xem chi tiết →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🙅 Từ chối tuân theo ↗️32×│ │
│  │ ┌──────────────────────┐  │ │
│  │ │██████░░░░ +20%       │  │ │
│  │ └──────────────────────┘  │ │
│  │ [Xem chi tiết →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  📂 Danh mục                    │
│                                 │
│  ┌─────┬─────┬─────┬─────┐     │
│  │Aggr │Avoid│Attn │Self │     │ Grid
│  │ ⚠️  │ 🏃  │ 📢  │ 🔄  │     │
│  │ 45  │ 32  │ 28  │ 22  │     │
│  └─────┴─────┴─────┴─────┘     │
│                                 │
│  [Xem tất cả 127 hành vi →]    │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝] [📊] [👤 Tôi]         │
└─────────────────────────────────┘
```

## Purpose

Thư viện hành vi với:

- Tìm kiếm và lọc
- Yêu thích
- Xu hướng
- Danh mục

## Components

### Search & Filters

- Search bar
- Filter, Sort, Favorites

### Favorites Section

- User's starred behaviors
- System usage count
- Student-specific count

### Trending Section

- Weekly trends
- Change percentage
- Trend indicators

### Categories Grid

- 4 main categories:
  - Aggression (⚠️)
  - Avoidance (🏃)
  - Attention (📢)
  - Self-stimulation (🔄)
- Count per category

## Interactions

- **Search** = Filter behaviors
- **Tap behavior** = View detail
- **Tap star** = Toggle favorite
- **Tap category** = View all in category
- **Tap "Xem tất cả"** = Full list

## Related Screens

- **Detail**: 19-dictionary-detail.md
- **Used in**: 17-abc-sheet.md

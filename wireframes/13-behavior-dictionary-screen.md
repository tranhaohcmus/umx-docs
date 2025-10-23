# 13. Màn hình Từ điển Hành vi

```
┌─────────────────────────────────────────┐
│  ← Từ điển Hành vi              🔍      │
├─────────────────────────────────────────┤
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  🔍 Tìm kiếm hành vi...         │   │
│  └─────────────────────────────────┘   │
│                                         │
│  Phổ biến nhất                          │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ ⚠️ Ném đồ vật                   │   │
│  │ Aggression • 127 lần ghi nhận  │   │
│  │ [Xem chi tiết →]               │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ 🏃 Tự ý rời khỏi chỗ ngồi       │   │
│  │ Avoidance • 98 lần ghi nhận    │   │
│  │ [Xem chi tiết →]               │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ 📢 La hét                       │   │
│  │ Attention • 85 lần ghi nhận    │   │
│  │ [Xem chi tiết →]               │   │
│  └─────────────────────────────────┘   │
│                                         │
│  Danh mục                               │
│                                         │
│  [Aggression] [Avoidance] [Attention]  │
│  [Self-stimulation] [Tất cả...]        │
│                                         │
├─────────────────────────────────────────┤
│  [🏠 Trang chủ] [📖 Từ điển] [👤 Profile]│
└─────────────────────────────────────────┘
```

## Mục đích

- Hiển thị danh sách hành vi phổ biến
- Phân loại theo category
- Truy cập nhanh thông tin hành vi

## Components

- **Search Bar**: Tìm kiếm hành vi
- **Behavior Cards**: Icon, tên, category, số lần ghi nhận
- **Category Filter**: Buttons filter theo loại hành vi
- **Bottom Navigation**: Trang chủ, Từ điển (active), Profile

## Interactions

- Type in search → Filter behaviors
- Tap behavior card → Navigate to behavior detail
- Tap category filter → Filter by category
- Pull to refresh → Refresh behavior list

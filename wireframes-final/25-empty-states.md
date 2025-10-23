# Empty States

## 1. No Students

```
┌─────────────────────────────────┐
│ 9:41          Educare   👤 ⚙️  │
├─────────────────────────────────┤
│                                 │
│                                 │
│         ┌─────────┐             │
│         │   👥    │             │
│         └─────────┘             │
│                                 │
│  Chưa có học sinh nào           │
│                                 │
│  Bắt đầu bằng cách thêm học sinh│
│  đầu tiên để theo dõi tiến độ   │
│  và ghi nhật ký học tập.        │
│                                 │
│  ┌───────────────────────────┐ │
│  │  ➕ THÊM HỌC SINH ĐẦU TIÊN│ │
│  └───────────────────────────┘ │
│                                 │
│  [📚 Xem hướng dẫn bắt đầu]    │
│                                 │
├─────────────────────────────────┤
│ [🏠 Nhà] [📝] [📊] [👤]         │
└─────────────────────────────────┘
```

## 2. No Sessions

```
┌─────────────────────────────────┐
│ 9:41      ← Bé An     ⋮  📤    │
├─────────────────────────────────┤
│                                 │
│  [Student Info Card]            │
│                                 │
│  📅 Lịch Buổi học              │
│                                 │
│         ┌─────────┐             │
│         │   📅    │             │
│         └─────────┘             │
│                                 │
│  Chưa có buổi học nào           │
│                                 │
│  Tạo buổi học đầu tiên để bắt đầu│
│  ghi nhật ký và theo dõi tiến độ│
│  học tập của bé.                │
│                                 │
│  ┌───────────────────────────┐ │
│  │  ✍️ TẠO THỦ CÔNG          │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │  🤖 TẠO VỚI AI            │ │
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝] [📊] [👤]             │
└─────────────────────────────────┘
```

## 3. No Behaviors in Dictionary Favorites

```
┌─────────────────────────────────┐
│ 9:41                        🔍  │
├─────────────────────────────────┤
│                                 │
│  📚 Từ điển Hành vi             │
│  [Search bar]                   │
│  [Filters]                      │
│                                 │
│  ⭐ Yêu thích của bạn (0)       │
│                                 │
│         ┌─────────┐             │
│         │   ⭐    │             │
│         └─────────┘             │
│                                 │
│  Chưa có yêu thích nào          │
│                                 │
│  Nhấn vào ⭐ trên bất kỳ hành vi│
│  nào để thêm vào danh sách      │
│  yêu thích của bạn.             │
│                                 │
│  ┌───────────────────────────┐ │
│  │  📚 KHÁM PHÁ THƯ VIỆN     │ │
│  └───────────────────────────┘ │
│                                 │
│  [Categories continue below...] │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝] [📊] [👤]             │
└─────────────────────────────────┘
```

## Purpose

Empty states cung cấp hướng dẫn rõ ràng khi không có dữ liệu.

## Components

### Common Elements

- **Icon**: Relevant large icon (60x60)
- **Title**: Short, clear heading
- **Description**: Helpful explanation
- **CTA**: Clear action button
- **Optional link**: Guide or help

### Variations

1. **No Students**

   - Icon: 👥
   - CTA: Thêm học sinh đầu tiên
   - Link: Hướng dẫn bắt đầu

2. **No Sessions**

   - Icon: 📅
   - CTA: Two options (Manual/AI)
   - Context: Shows student info

3. **No Behaviors**
   - Icon: ⭐
   - Description: How to add favorites
   - CTA: Explore library
   - Fallback: Shows categories

## Design Principles

- **Clear hierarchy**: Icon → Title → Description → CTA
- **Friendly tone**: Encouraging, not empty
- **Actionable**: Always provide next step
- **Context-aware**: Relevant to current screen
- **Helpful**: Include guides or tips

## Related Screens

- **Dashboard**: No students
- **Student Detail**: No sessions
- **Dictionary**: No favorites

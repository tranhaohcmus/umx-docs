# Tạo thủ công - Step 2 (Content)

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41   ← Tạo buổi học   [✕]    │
├─────────────────────────────────┤
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  Bước 2/3: Nội dung dạy học    │
│                                 │
│  📚 Danh sách nội dung (2)     │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ⋮⋮ 1. Phân biệt màu sắc  ⋮│ │ Drag handle
│  │    🧠 Nhận thức           │ │ Domain tag
│  │                           │ │
│  │    🎯 Mục tiêu: 3         │ │
│  │    • Gọi tên màu đỏ       │ │
│  │    • Nhận diện màu xanh   │ │
│  │    • Phân biệt 2 màu      │ │
│  │                           │ │
│  │    [✏️ Sửa]  [🗑️ Xóa]     │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ⋮⋮ 2. Hoạt động vận động ⋮│ │
│  │    🏃 Vận động            │ │ Domain tag
│  │                           │ │
│  │    🎯 Mục tiêu: 4         │ │
│  │    • Chạy thẳng 10m       │ │
│  │    • Nhảy tại chỗ 5 lần   │ │
│  │    • Bắt bóng bằng 2 tay  │ │
│  │    • Ném bóng vào rổ      │ │
│  │                           │ │
│  │    [✏️ Sửa]  [🗑️ Xóa]     │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ➕ Thêm nội dung mới       │ │ Secondary CTA
│  └───────────────────────────┘ │
│                                 │
│  💡 Gợi ý: Kéo thả để sắp xếp  │
│                                 │
│  ┌───────────────────────────┐ │
│  │    TIẾP TỤC (2/3) →       │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

## Purpose

Step 2 thu thập nội dung dạy học và mục tiêu cho buổi học.

## Components

### Progress Stepper

- Progress: 66% (Step 2/3)

### Content List

- Reorderable content cards
- Each card shows:
  - Title with drag handle
  - Number of goals
  - Goal list
  - Edit/Delete buttons

### Actions

- Add content button
- Continue to Step 3

## Interactions

### Gestures

- **Drag ⋮⋮** = Reorder items
- **Swipe left** = Quick delete
- **Tap item** = Expand/collapse
- **Tap "Thêm nội dung"** = Open modal

### Validation

- Must have at least 1 content item
- Each content must have at least 1 goal

## Related Screens

- **Previous**: 04-manual-step1.md
- **Next**: 07-manual-step3.md
- **Modal**: 06-modal-add-content.md

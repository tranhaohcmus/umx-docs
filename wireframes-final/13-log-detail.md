# Ghi nhật ký - Chi tiết mục tiêu

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41  ← Phân biệt màu   💾 [✕] │
│          🧠 Nhận thức          │
├─────────────────────────────────┤
│                                 │
│  ⚠️ Nhớ lưu thường xuyên       │
│  Tự động lưu: 2 phút trước     │
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  1/4: Đánh giá Mục tiêu        │
│                                 │
│  📋 Danh sách Mục tiêu          │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 1. Gọi tên màu đỏ         │ │
│  │                           │ │
│  │ Đánh giá:                 │ │
│  │ ● Đạt  ○ Đang học ○ Chưa │ │ Radio buttons
│  │                           │ │
│  │ 📝 Ghi chú nhanh:         │ │
│  │ ┌─────────────────────┐   │ │
│  │ │ Con đã gọi đúng...  │   │ │
│  │ └─────────────────────┘   │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 2. Nhận diện màu đỏ       │ │
│  │                           │ │
│  │ Đánh giá:                 │ │
│  │ ● Đạt  ○ Đang học ○ Chưa │ │
│  │                           │ │
│  │ 📝 Ghi chú: (Tùy chọn)    │ │
│  │ ┌─────────────────────┐   │ │
│  │ │ ...                 │   │ │
│  │ └─────────────────────┘   │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 3. Phân biệt đỏ/xanh      │ │
│  │                           │ │
│  │ Đánh giá:                 │ │
│  │ ○ Đạt  ● Đang học ○ Chưa │ │
│  │                           │ │
│  │ 📝 Ghi chú:               │ │
│  │ ┌─────────────────────┐   │ │
│  │ │ Còn nhầm lẫn đôi khi│   │ │
│  │ └─────────────────────┘   │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │   TIẾP TỤC (1/4) →        │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
│  [Lưu nháp]  [Bỏ qua bước này] │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

## Purpose

Step 1/4 của quy trình ghi nhật ký - đánh giá từng mục tiêu học tập.

## Components

### Auto-save Indicator

- Shows last save time
- Warning to save regularly

### Progress Stepper

- Step 1/4
- Progress bar

### Goal Cards

- Each goal has:
  - Title
  - Assessment radio buttons (Đạt/Đang học/Chưa)
  - Notes field (optional)

### Actions

- Continue button
- Save draft
- Skip step

## Interactions

- **Select assessment** = Mark goal status
- **Type notes** = Optional details
- **Tap TIẾP TỤC** = Go to Step 2
- **Tap Lưu nháp** = Save and exit
- **Tap Bỏ qua** = Skip to next step

### Auto-save

- Saves every 2 minutes
- Shows save status

## Related Screens

- **Previous**: 12-log-overview.md
- **Next**: 14-log-attitude.md

# Ghi nhật ký - Đánh giá Tất cả Mục tiêu

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41  ← Đánh giá      💾 [✕]   │
├─────────────────────────────────┤
│                                 │
│  ⚠️ Nhớ lưu thường xuyên       │
│  Tự động lưu: 2 phút trước     │
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  Bước 1/4: Đánh giá Mục tiêu   │
│                                 │
│  📋 Đánh giá toàn bộ buổi học  │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 1. Phân biệt màu sắc      │ │
│  │    🧠 Nhận thức           │ │
│  │ ──────────────────────────│ │
│  │                           │ │
│  │ 1.1. Gọi tên màu đỏ       │ │
│  │ ● Đạt  ○ Đang học ○ Chưa │ │
│  │                           │ │
│  │ 1.2. Nhận diện màu xanh   │ │
│  │ ● Đạt  ○ Đang học ○ Chưa │ │
│  │                           │ │
│  │ 1.3. Phân biệt 2 màu      │ │
│  │ ○ Đạt  ● Đang học ○ Chưa │ │
│  │                           │ │
│  │ 📝 Ghi chú nội dung:      │ │
│  │ ┌─────────────────────┐   │ │
│  │ │ Còn nhầm đôi khi... │   │ │
│  │ └─────────────────────┘   │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 2. Vận động tinh          │ │
│  │    🏃 Vận động            │ │
│  │ ──────────────────────────│ │
│  │                           │ │
│  │ 2.1. Chạy thẳng 10m       │ │
│  │ ● Đạt  ○ Đang học ○ Chưa │ │
│  │                           │ │
│  │ 2.2. Nhảy tại chỗ 5 lần   │ │
│  │ ● Đạt  ○ Đang học ○ Chưa │ │
│  │                           │ │
│  │ 2.3. Bắt bóng 2 tay       │ │
│  │ ○ Đạt  ● Đang học ○ Chưa │ │
│  │                           │ │
│  │ 2.4. Ném bóng vào rổ      │ │
│  │ ○ Đạt  ○ Đang học ● Chưa │ │
│  │                           │ │
│  │ 📝 Ghi chú nội dung:      │ │
│  │ ┌─────────────────────┐   │ │
│  │ │ (Tùy chọn)          │   │ │
│  │ └─────────────────────┘   │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 3. Nhận biết cảm xúc      │ │
│  │    🤝 Xã hội              │ │
│  │ ──────────────────────────│ │
│  │                           │ │
│  │ 3.1. Nhận biết vui        │ │
│  │ ● Đạt  ○ Đang học ○ Chưa │ │
│  │                           │ │
│  │ 3.2. Nhận biết buồn       │ │
│  │ ● Đạt  ○ Đang học ○ Chưa │ │
│  │                           │ │
│  │ 3.3. Nhận biết giận       │ │
│  │ ○ Đạt  ● Đang học ○ Chưa │ │
│  │                           │ │
│  │ 📝 Ghi chú: (Tùy chọn)    │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 4. Hoạt động nhóm         │ │
│  │    🤝 Xã hội              │ │
│  │ ──────────────────────────│ │
│  │ [Hiển thị mục tiêu...]    │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 5. Ôn tập đánh giá        │ │
│  │    🧠 Nhận thức           │ │
│  │ ──────────────────────────│ │
│  │ [Hiển thị mục tiêu...]    │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │   TIẾP TỤC (1/4) →        │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
│  [Lưu nháp]                     │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

## Purpose

Bước 1/4 - Đánh giá TẤT CẢ mục tiêu của TẤT CẢ nội dung trong buổi học trong 1 màn hình duy nhất.

## Components

### Auto-save Indicator

- Shows last save time
- Warning to save regularly

### Progress Stepper

- Step 1/4
- Progress bar

### Content Sections (Scrollable)

Each content section includes:

- Content name + Domain tag
- All goals with radio button assessments
- Optional notes field per content

### Goal Assessment

- Radio buttons for each goal:
  - ● Đạt (Achieved)
  - ○ Đang học (In Progress)
  - ○ Chưa (Not Yet)

### Notes Field

- Optional per content
- Max 500 characters
- Collapsible if empty

### Actions

- Continue button → Next step (Attitude)
- Save draft

## Interactions

### Scrolling

- **Vertical scroll** = View all content sections
- Content sections are stacked vertically
- Smooth scroll with momentum

### Assessment

- **Tap radio button** = Select assessment for goal
- **Tap notes field** = Expand and type
- Real-time validation

### Actions

- **Tap TIẾP TỤC** = Save all assessments → Go to Step 2 (Attitude)
- **Tap Lưu nháp** = Save and exit to overview
- **Back button** = Return to overview with confirmation

### Auto-save

- Saves every 2 minutes
- Shows save status
- Saves on navigation away

### Validation

- No goals are required (can skip)
- At least 1 goal assessed recommended
- Warning if no assessments made

## Key Changes from Old Flow

**Old**: Evaluate 1 content at a time (multiple screens)
**New**: Evaluate ALL content in 1 scrollable screen

Benefits:

- ✅ Faster workflow
- ✅ See full context
- ✅ Less navigation
- ✅ Better overview

## Notes

- **Scrollable long form**: May have 10+ content sections
- **Performance**: Virtualized list for many goals
- **Progress indicator**: Optional sticky header showing scroll progress
- **Quick jump**: Optional floating button to jump between content sections

## Related Screens

- **Previous**: 12-log-overview.md
- **Next**: 14-log-attitude.md

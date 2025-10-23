# Ghi nhật ký - Đánh giá Tất cả Mục tiêu

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41  ← Đánh giá      💾 [✕]   │
├─────────────────────────────────┤
│  [1] [2] [3] [4] [5]  │ Quick nav sidebar
│                                 │
│  ⚠️ Nhớ lưu thường xuyên       │
│  Tự động lưu: 2 phút trước     │
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  Bước 1/4: Đánh giá Mục tiêu   │
│  ████████░░░░░░░░░░░░ 25%     │
│                                 │
│  📋 Đánh giá toàn bộ buổi học  │
│                                 │
│  ┌───────────────────────────┐ │ ← Sticky when scrolling
│  │ 1. Phân biệt màu sắc      │ │
│  │    🧠 Nhận thức           │ │
│  ├───────────────────────────┤ │
│  │                           │ │
│  │ 1.1. Gọi tên màu đỏ       │ │
│  │ ● Đạt  ○ Chưa đạt ○ N/A  │ │
│  │                           │ │
│  │ 1.2. Nhận diện màu xanh   │ │
│  │ ● Đạt  ○ Chưa đạt ○ N/A  │ │
│  │                           │ │
│  │ 1.3. Phân biệt 2 màu      │ │
│  │ ○ Đạt  ● Chưa đạt ○ N/A  │ │
│  │                           │ │
│  │ 📝 Ghi chú nội dung:      │ │
│  │ ┌─────────────────────┐   │ │
│  │ │ Còn nhầm đôi khi... │   │ │
│  │ └─────────────────────┘   │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │ ← Sticky header
│  │ 2. Vận động tinh          │ │
│  │    🏃 Vận động            │ │
│  ├───────────────────────────┤ │
│  │                           │ │
│  │ 2.1. Chạy thẳng 10m       │ │
│  │ ● Đạt  ○ Chưa đạt ○ N/A  │ │
│  │                           │ │
│  │ 2.2. Nhảy tại chỗ 5 lần   │ │
│  │ ● Đạt  ○ Chưa đạt ○ N/A  │ │
│  │                           │ │
│  │ 2.3. Bắt bóng 2 tay       │ │
│  │ ○ Đạt  ● Chưa đạt ○ N/A  │ │
│  │                           │ │
│  │ 2.4. Ném bóng vào rổ      │ │
│  │ ○ Đạt  ○ Chưa đạt ● N/A  │ │
│  │                           │ │
│  │ 📝 Ghi chú nội dung:      │ │
│  │ ┌─────────────────────┐   │ │
│  │ │ (Tùy chọn)          │   │ │
│  │ └─────────────────────┘   │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │ ← Sticky header
│  │ 3. Nhận biết cảm xúc      │ │
│  │    🤝 Xã hội              │ │
│  ├───────────────────────────┤ │
│  │                           │ │
│  │ 3.1. Nhận biết vui        │ │
│  │ ● Đạt  ○ Chưa đạt ○ N/A  │ │
│  │                           │ │
│  │ 3.2. Nhận biết buồn       │ │
│  │ ● Đạt  ○ Chưa đạt ○ N/A  │ │
│  │                           │ │
│  │ 3.3. Nhận biết giận       │ │
│  │ ○ Đạt  ● Chưa đạt ○ N/A  │ │
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

- **Step 1/4**: "Đánh giá Mục tiêu"
- **Visual progress bar**: ████████░░░░░░░░░░░░ 25%
- Clear indication of current step

### Quick Navigation Sidebar

- **[1] [2] [3] [4] [5]**: Clickable content numbers
- Jumps to that content section when tapped
- Current section highlighted
- Always visible on left side
- Helps navigate long scrolling list

### Content Sections (Scrollable with Sticky Headers)

Each content section includes:

- **Sticky header**: Content name + domain tag stays visible when scrolling
- Content number and name
- Domain tag with icon

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

### Gestures

- **Scroll vertically**: Browse all content sections
- **Tap quick nav number**: Jump to that content section instantly
- **Tap radio button**: Select goal status
- **Type in notes**: Add context
- **Pull down**: Refresh/Save draft
- **Swipe horizontally between content** (optional): Alternative navigation

### Sticky Headers Behavior

- When scrolling, content header ("1. Phân biệt màu sắc" + domain tag) sticks to top
- Next content's header pushes previous one up
- Always know which content you're evaluating

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

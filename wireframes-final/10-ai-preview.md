# AI Preview & Edit

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41  ← Kết quả AI    💾 [✕]   │
├─────────────────────────────────┤
│                                 │
│  ✨ AI đã tạo 12 buổi học       │
│                                 │
│  [Chọn tất cả] [Bỏ chọn]       │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ☑️ T2, 21/10 • Sáng  ↕️   │ │ Collapsible
│  │ ──────────────────────────│ │
│  │ 8:00-11:00 • 3 nội dung   │ │
│  │                           │ │
│  │ 1. Ai đây? (Nhận diện)    │ │
│  │    • Nhận biết tên mình   │ │
│  │    • Trỏ vào ảnh bản thân │ │
│  │    • Phản ứng khi gọi     │ │
│  │                           │ │
│  │ 2. Hoạt động vận động     │ │
│  │    • Chạy thẳng 10m       │ │
│  │    • Nhảy 5 lần           │ │
│  │    • Bắt bóng 2 tay       │ │
│  │                           │ │
│  │ 3. Nghỉ giải lao          │ │
│  │    • Tự uống nước         │ │
│  │    • Rửa tay đúng cách    │ │
│  │                           │ │
│  │ [✏️ Sửa]      [🗑️ Xóa]    │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ☑️ T2, 21/10 • Chiều ↕️   │ │
│  │ ──────────────────────────│ │
│  │ 14:00-16:30 • 4 nội dung  │ │
│  │ [Nhấn để xem]             │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ☑️ T3, 22/10 • Sáng  ↕️   │ │
│  │ ──────────────────────────│ │
│  │ 14:00-16:30 • 4 nội dung  │ │
│  │ [Nhấn để xem]             │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ + 9 buổi khác...          │ │
│  │ [Mở rộng tất cả]          │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ✅ TẠO 12 BUỔI HỌC (12)   │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
│  [Sửa hàng loạt] [Chọn lại]    │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

## Purpose

Preview AI-generated sessions với khả năng:

- Xem chi tiết từng buổi
- Chỉnh sửa, xóa, copy sessions
- Chọn/bỏ chọn sessions
- Tạo hàng loạt

## Components

### Header

- Success message
- Session count
- Save & Close buttons

### Bulk Actions

- Select all/Deselect all
- Edit multiple
- Reselect criteria

### Session Cards

- Checkbox selection
- Collapsible content
- Date, time, content count
- Full content list with goals
- Action buttons per session

### CTA

- Create selected sessions
- Count badge

## Interactions

### Gestures

- **Tap header** = Expand/collapse session
- **Swipe left** = Quick delete
- **Long press** = Select multiple
- **Pull down** = Refresh

### Actions

- **Edit session** = Inline edit
- **Delete session** = Remove from list
- **Copy session** = Duplicate
- **Select/Deselect** = Toggle checkbox

## Validation

- Must select at least 1 session
- Can edit time, content, goals
- Duplicate detection

## Related Screens

- **Previous**: 09-ai-processing.md
- **Success**: 27-success-states.md

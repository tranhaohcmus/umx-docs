# Ghi nhật ký - Overview

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41  ← T3, 22/10 Sáng  💾 ⋮   │
├─────────────────────────────────┤
│                                 │
│  ┌───────────────────────────┐ │
│  │ BA Bé An • 5 tuổi         │ │
│  │ Buổi sáng: 8:00-11:00     │ │
│  └───────────────────────────┘ │
│                                 │
│  📊 Tiến độ                     │
│  ┌───────────────────────────┐ │
│  │ ████████░░░░░░ 60%        │ │
│  │ 3/5 nội dung hoàn thành   │ │
│  │ Còn lại: 2 nội dung       │ │
│  └───────────────────────────┘ │
│                                 │
│  💡 Nhấn vào nội dung để ghi   │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ✅ 1. Phân biệt màu sắc   │ │
│  │    🧠 Nhận thức           │ │
│  │ ──────────────────────────│ │
│  │ 🎯 3/3 mục tiêu đạt       │ │
│  │ ⏰ Hoàn thành: 09:15      │ │
│  │ 😊 Thái độ: Tốt           │ │
│  │                           │ │
│  │ [Xem chi tiết]            │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ✅ 2. Vận động tinh       │ │
│  │    🏃 Vận động            │ │
│  │ ──────────────────────────│ │
│  │ 🎯 4/4 mục tiêu đạt       │ │
│  │ ⏰ Hoàn thành: 10:00      │ │
│  │ 😐 Thái độ: Trung bình    │ │
│  │                           │ │
│  │ [Xem chi tiết]            │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ✅ 3. Nhận biết cảm xúc   │ │
│  │    🤝 Xã hội              │ │
│  │ ──────────────────────────│ │
│  │ 🎯 2/3 mục tiêu đạt       │ │
│  │ ⏰ Hoàn thành: 10:30      │ │
│  │ ⚠️ 1 hành vi ghi nhận     │ │
│  │                           │ │
│  │ [Xem chi tiết]            │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ⭕ 4. Hoạt động nhóm       │ │ Tappable
│  │    🤝 Xã hội              │ │
│  │ ──────────────────────────│ │
│  │ 🎯 3 mục tiêu cần ghi     │ │
│  │ ⏰ Chưa ghi               │ │
│  │                           │ │
│  │ [NHẤN ĐỂ GHI →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ⭕ 5. Ôn tập đánh giá      │ │
│  │    🧠 Nhận thức           │ │
│  │ ──────────────────────────│ │
│  │ 🎯  2 mục tiêu cần ghi     │ │
│  │ ⏰ Chưa ghi               │ │
│  │                           │ │
│  │ [NHẤN ĐỂ GHI →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  [➕ Thêm nội dung khác]        │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ✅ HOÀN TẤT BUỔI HỌC      │ │ Disabled until 100%
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

## Purpose

Màn hình tổng quan ghi nhật ký hiển thị:

- Tiến độ hoàn thành
- Danh sách nội dung với trạng thái
- Truy cập nhanh để ghi từng nội dung

## Components

### Session Info Card

- Student avatar & name
- Session date & time

### Progress Card

- Progress bar
- Completed/Total count
- Remaining items

### Content Cards

- **Completed** (✅):
  - Goals achieved count
  - Completion time
  - Mood indicator
  - Behavior count (if any)
  - [Xem chi tiết] button
- **Pending** (⭕):
  - Goals count
  - Status: "Chưa ghi"
  - [NHẤN ĐỂ GHI →] button

### Actions

- Add extra content
- Complete session (disabled until 100%)

## Interactions

### Gestures

- **Tap completed item** = View detail (read-only)
- **Tap pending item** = Start recording
- **Swipe left** = Quick options
- **Pull down** = Refresh

### Navigation

- **Completed content** → Detail view (read-only)
- **Pending content** → Log detail screen
- **HOÀN TẤT** → Confirmation dialog → Success

### Auto-save

- Saves progress every 2 minutes
- Shows last save time

## Related Screens

- **Previous**: 11-session-selector.md
- **Alternative**: 02-student-detail.md (direct from student)
- **Next**: 13-log-detail.md

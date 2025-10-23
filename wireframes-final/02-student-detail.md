# Student Detail - Chi tiết học sinh

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41      ← Bé An     ⋮  📤    │ Nav Bar
├─────────────────────────────────┤
│                                 │
│  ┌───────────────────────────┐ │
│  │       ┌─────────┐          │ │
│  │       │   BA    │          │ │ Avatar 80x80
│  │       └─────────┘          │ │
│  │                            │ │
│  │    Bé An (Nguyễn Văn An)  │ │
│  │    5 tuổi • Nam            │ │
│  └───────────────────────────┘ │
│                                 │
│  📊 Thống kê                   │
│  ┌──────┬──────┬──────┬──────┐│
│  │ 89%  │ 12   │  8   │  45  ││
│  │ Hoàn │ Buổi │ Hành │ Giờ  ││
│  │ thành│ học  │ vi   │ học  ││
│  └──────┴──────┴──────┴──────┘│
│                                 │
│  ─────────────────────────────  │
│                                 │
│  📅 Lịch Buổi học              │
│                                 │
│  ┌───────────────────────────┐ │
│  │ Tháng 10/2025      ◀ Tuần▶│ │
│  │                            │ │
│  │ T2  T3  T4  T5  T6  T7  CN │ │
│  │ ──  ──  ──  ──  ──  ──  ── │ │
│  │ 21  22  23  24  25  26  27 │ │
│  │ ⚠️  ✅  🔄  ⏰  ⭕  ⭕  ⭕ │ │
│  │                            │ │
│  │ • ✅ Hoàn thành            │ │
│  │ • 🔄 Đang ghi              │ │
│  │ • ⏰ Đã lên lịch           │ │
│  │ • ⚠️ Quá hạn/Chưa ghi     │ │
│  │ • ⭕ Chưa có buổi          │ │
│  └───────────────────────────┘ │
│                                 │
│  🎯 Hôm nay - T3, 22/10        │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ✅ BUỔI SÁNG              │ │
│  │ 8:00 - 11:00              │ │
│  │                            │ │
│  │ ████████████ 100%         │ │
│  │ 5/5 nội dung hoàn thành   │ │
│  │ Ghi lúc: 11:30            │ │
│  │                            │ │
│  │ [Xem lại] [Chia sẻ]       │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🔄 BUỔI CHIỀU • ĐANG GHI  │ │
│  │ 14:00 - 16:30             │ │
│  │                            │ │
│  │ ████████░░░░ 60%          │ │
│  │ 3/5 nội dung đã ghi       │ │
│  │ Lưu lần cuối: 15:20       │ │
│  │                            │ │
│  │ [TIẾP TỤC GHI →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  ⏰ Sắp tới                     │
│                                 │
│  ┌───────────────────────────┐ │
│  │ T4, 23/10 • Buổi sáng     │ │
│  │ 5 nội dung • Chưa bắt đầu │ │
│  │ [Xem trước]               │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ➕ TẠO BUỔI HỌC MỚI       │ │ CTA
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

## Purpose

Màn hình chi tiết học sinh hiển thị:

- Thông tin cá nhân và thống kê tổng quan
- Lịch buổi học với trạng thái trực quan
- Danh sách buổi học hôm nay và sắp tới
- Truy cập nhanh để ghi nhật ký hoặc tạo buổi mới

## Components

### Navigation Bar

- **Back button** (←): Return to Dashboard
- **Student name**: "Bé An"
- **More menu** (⋮): Edit student, Delete, Archive
- **Share button** (📤): Export reports

### Student Info Card

- **Avatar**: 80x80pt with initials
- **Full name**: "Bé An (Nguyễn Văn An)"
- **Age & Gender**: "5 tuổi • Nam"

### Statistics Grid (4 metrics)

1. **Hoàn thành**: 89% completion rate
2. **Buổi học**: 12 total sessions
3. **Hành vi**: 8 behaviors tracked
4. **Giờ học**: 45 total hours

### Calendar Widget

- **Month/Week selector**: "Tháng 10/2025" with arrows
- **Week view**: T2-CN (Mon-Sun)
- **Status icons**:
  - ✅ Completed
  - 🔄 In progress
  - ⏰ Scheduled
  - ⚠️ Overdue/Not logged
  - ⭕ No session
- **Legend**: Status descriptions

### Today's Sessions

- **Section header**: "🎯 Hôm nay - T3, 22/10"
- **Session cards** (repeatable):
  - **Status badge**: ✅ BUỔI SÁNG / 🔄 BUỔI CHIỀU • ĐANG GHI
  - **Time**: "8:00 - 11:00"
  - **Progress bar**: Visual completion
  - **Progress text**: "5/5 nội dung hoàn thành"
  - **Timestamp**: "Ghi lúc: 11:30" or "Lưu lần cuối: 15:20"
  - **Action buttons**:
    - Completed: [Xem lại] [Chia sẻ]
    - In progress: [TIẾP TỤC GHI →]

### Upcoming Sessions

- **Section header**: "⏰ Sắp tới"
- **Session preview**:
  - Date: "T4, 23/10"
  - Time: "Buổi sáng"
  - Content count: "5 nội dung"
  - Status: "Chưa bắt đầu"
  - **Action**: [Xem trước]

### Create Session CTA

- **Button**: "➕ TẠO BUỔI HỌC MỚI"
- Opens bottom sheet to choose method

### Bottom Navigation

- 🏠 Nhà
- 📝 Ghi
- 📊 Báo
- 👤 Tôi

## Interactions

### Gestures

- **Swipe calendar left/right** = Change week
- **Tap date** = Jump to that day and show sessions
- **Tap session card** = Open session detail
- **Pull down** = Refresh data
- **Long press session** = Quick options (Edit, Delete, Share)

### Navigation

- **Back button** → Dashboard
- **More menu** → Edit/Delete/Archive student
- **Share button** → Export student report (PDF/CSV)
- **Completed session** → Session detail (read-only)
- **In-progress session** → Continue logging
- **Upcoming session** → Preview session plan
- **Create button** → Bottom sheet (Manual/AI choice)

### States

- **Loading**: Skeleton calendar and session cards
- **Empty sessions**: "Chưa có buổi học nào. Tạo buổi học đầu tiên!"
- **No data for selected date**: "Không có buổi học vào ngày này"
- **Error**: "Không thể tải dữ liệu. Vui lòng thử lại."

## Validation Rules

- Calendar shows current week by default
- Sessions ordered by time (earliest first)
- Progress bars calculate from logged content items
- Status badges update in real-time
- Overdue sessions highlighted with ⚠️ after 24 hours

## Notes

- **Auto-save**: In-progress sessions auto-save every 2 minutes
- **Offline mode**: View cached sessions, edit syncs when online
- **Calendar navigation**: Tap arrows to change week, tap month to select different month
- **Quick access**: Tap calendar date to jump to sessions
- **Export**: Share button exports all student data (logs, behaviors, progress)
- **Accessibility**: Screen reader support for calendar and session status
- **Performance**: Lazy load sessions as user scrolls

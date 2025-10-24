# Student Detail - Chi tiết học sinh

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41      ← Bé An     ⋮  📤    │ Nav Bar (nút xuất báo cáo pdf,)
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
│  │ ◀ Tuần trước │ Tuần này │ Tuần sau ▶ │ │
│  │                            │ │
│  │ T2  T3  T4  T5  T6  T7  CN │ │
│  │ ──  ──  ──  ──  ──  ──  ── │ │
│  │ 21  22  23  24  25  26  27 │ │
│  │ ⚠️  ✅  ⏰  ⏰  ⭕  ⭕  ⭕ │ │
│  │                            │ │
│  │ • ✅ Hoàn thành            │ │
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
│  │ Đã hoàn thành đánh giá    │ │
│  │ Ghi lúc: 11:30            │ │
│  │                            │ │
│  │ [Xem chi tiết]             │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ⏰ BUỔI CHIỀU             │ │
│  │ 14:00 - 16:30             │ │
│  │                            │ │
│  │ Chưa bắt đầu đánh giá     │ │
│  │                            │ │
│  │ [BẮT ĐẦU GHI →]           │ │
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
  - ✅ Completed (evaluated)
  - ⏰ Scheduled (not started)
  - ⚠️ Overdue/Not logged (past due date)
  - ⭕ No session
- **Legend**: Status descriptions

### Today's Sessions

- **Section header**: "🎯 Hôm nay - T3, 22/10"
- **Session cards** (repeatable):
  - **Menu icon** (⋮): Right side, opens action menu
  - **Status badge**: ✅ BUỔI SÁNG (Completed) / ⏰ BUỔI CHIỀU (Not started)
  - **Time**: "8:00 - 11:00"
  - **Status text**:
    - Completed: "Đã hoàn thành đánh giá"
    - Not started: "Chưa bắt đầu đánh giá"
  - **Timestamp**: "Ghi lúc: 11:30" (if completed)
  - **Action buttons**:
    - Completed: [Xem chi tiết] [Chia sẻ]
    - Not started: [BẮT ĐẦU GHI →]

**Session Card Menu (⋮):**

```
┌─────────────────────────┐
│ ✏️ Sửa buổi học         │
│ 🗑️ Xóa buổi học         │
│ 📋 Sao chép             │
│ 📤 Chia sẻ              │
│ ❌ Hủy                  │
└─────────────────────────┘
```

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
- **Tap ⋮ menu** = Open session actions menu
- **Long press session** = Quick options (same as ⋮ menu)
- **Pull down** = Refresh data
- **Swipe left on session card** = Quick delete (shows confirmation)

### Navigation

- **Back button** → Dashboard
- **More menu** → Edit/Delete/Archive student
- **Share button** → Export student report (PDF/CSV)
- **Completed session** → Session detail (12-log-overview.md - read-only)
- **Not started session** → Start logging (12-log-overview.md)
- **Upcoming session** → Preview session plan
- **Create button** → Bottom sheet (Manual/AI choice)
- **Session ⋮ menu**:
  - **Sửa buổi học** → 04a-edit-session.md (Edit session basic info)
  - **Xóa buổi học** → Delete confirmation dialog (30-confirmations.md)
  - **Sao chép** → Duplicate session
  - **Chia sẻ** → Export session report

### States

- **Loading**: Skeleton calendar and session cards
- **Empty sessions**: "Chưa có buổi học nào. Tạo buổi học đầu tiên!"
- **No data for selected date**: "Không có buổi học vào ngày này"
- **Error**: "Không thể tải dữ liệu. Vui lòng thử lại."

## Notes

- **Removed "TIẾP TỤC GHI"**: Sessions are either "Not started" or "Completed"
- **Simplified states**: Only 2 states - waiting to start or finished
- **No progress tracking**: Evaluation is atomic (all-or-nothing)
- **Calendar icons updated**:
  - ✅ Completed (evaluated)
  - ⏰ Scheduled (not started)
  - ⚠️ Overdue (past due date, not started)

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

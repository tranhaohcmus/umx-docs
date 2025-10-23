# Chọn phiên để ghi

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41  ← Chọn phiên học    🔍    │
├─────────────────────────────────┤
│                                 │
│  📅 Hôm nay - T3, 22/10/2025   │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 👤 BA Bé An • 5 tuổi      │ │
│  │ ──────────────────────────│ │
│  │ ⏰ Buổi sáng: 8:00-11:00  │ │
│  │ 🟢 Đang diễn ra           │ │
│  │ 📊 60% hoàn thành         │ │
│  │                           │ │
│  │ [TIẾP TỤC GHI →]          │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 👤 MH Minh Hiếu • 4 tuổi  │ │
│  │ ──────────────────────────│ │
│  │ ⏰ Buổi chiều: 14:00-17:00│ │
│  │ ⭕ Chưa bắt đầu           │ │
│  │                           │ │
│  │ [BẮT ĐẦU GHI →]           │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 👤 TN Thu Nga • 6 tuổi    │ │
│  │ ──────────────────────────│ │
│  │ ⏰ Buổi tối: 18:00-20:00  │ │
│  │ ⭕ Chưa bắt đầu           │ │
│  │                           │ │
│  │ [BẮT ĐẦU GHI →]           │ │
│  └───────────────────────────┘ │
│                                 │
│  📅 Các ngày khác               │
│                                 │
│  ┌───────────────────────────┐ │
│  │ T2, 21/10                 │ │
│  │ ──────────────────────────│ │
│  │ ✅ BA Bé An - Sáng        │ │
│  │ ✅ MH Minh Hiếu - Chiều   │ │
│  │                           │ │
│  │ [Xem 2 phiên →]           │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 📅 Xem theo lịch           │ │
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

## Purpose

Màn hình cho phép chọn phiên học để ghi nhật ký:

- Hiển thị các phiên hôm nay
- Ưu tiên phiên đang diễn ra hoặc có tiến độ
- Truy cập phiên ngày khác
- Context-aware: smart default từ màn trước

## Components

### Header

- Title: "Chọn phiên học"
- Back button
- Search icon (tìm học sinh)

### Today's Sessions

- Date badge
- List of sessions with:
  - Student info (avatar, name, age)
  - Time & session type
  - Status indicator:
    - 🟢 Đang diễn ra
    - ⭕ Chưa bắt đầu
    - ✅ Đã hoàn thành
  - Progress (if in-progress)
  - Action button:
    - [TIẾP TỤC GHI →] (in-progress)
    - [BẮT ĐẦU GHI →] (not started)
    - [XEM CHI TIẾT] (completed)

### Previous Days

- Expandable list by date
- Summary count per day
- Quick access

### Calendar View

- Button to open calendar picker
- Jump to specific date

## Interactions

### Gestures

- **Tap session** = Navigate to log overview
- **Swipe left** = Quick actions (View/Delete)
- **Long press** = More options
- **Pull down** = Refresh

### Smart Defaults

1. **From Dashboard**:

   - Show all today's sessions
   - Highlight in-progress first

2. **From Student Detail**:

   - Pre-filter to that student's sessions
   - Show today + upcoming

3. **Resume In-Progress**:
   - If 1 session in-progress → Show dialog to resume
   - If multiple → Show this selector

### Resume Dialog (Context)

```
┌─────────────────────────────────┐
│  Tiếp tục ghi?                  │
│                                 │
│  BA Bé An - Buổi sáng           │
│  📊 60% hoàn thành              │
│  ⏰ Bắt đầu: 08:00              │
│                                 │
│  [Tiếp tục]  [Chọn phiên khác] │
└─────────────────────────────────┘
```

### Empty States

**No sessions today:**

```
┌─────────────────────────────────┐
│  📅 Chưa có phiên học hôm nay  │
│                                 │
│  [➕ Tạo phiên mới]             │
│  [📅 Xem lịch]                  │
└─────────────────────────────────┘
```

## Navigation Flow

### Entry Points

1. **Tap [📝 Ghi] in nav bar**:

   - Check for in-progress sessions
   - If 1 in-progress → Show resume dialog
   - If 0 or multiple → Show selector

2. **From Student Detail**:

   - Pre-filtered to that student
   - Smart default: today's session

3. **From Dashboard**:
   - Show all sessions

### Exit Points

- **Select session** → 12-log-overview.md (with sessionId)
- **Create new** → 03-create-method-sheet.md
- **Back** → Previous screen

## Data Requirements

### API Calls

```javascript
// Get sessions for selector
GET /api/sessions?date=2025-10-22&status=in-progress,pending

Response:
{
  "today": [
    {
      "id": "sess_123",
      "student": {
        "id": "std_1",
        "name": "Bé An",
        "nickname": "BA",
        "age": 5
      },
      "date": "2025-10-22",
      "timeSlot": "morning",
      "startTime": "08:00",
      "endTime": "11:00",
      "status": "in-progress",
      "progress": {
        "completed": 3,
        "total": 5,
        "percentage": 60
      }
    }
  ],
  "previousDays": [...]
}
```

### Local Storage

- Cache last selected session
- Resume prompt preference

## Validation Rules

- Can only start logging for:
  - Today's sessions
  - Sessions within time range ± 1 hour
- Completed sessions: read-only

## Related Screens

- **Entry from**: Navigation bar [📝 Ghi]
- **Next**: 12-log-overview.md (Log Overview)
- **Alternative**: 03-create-method-sheet.md (Create new session)

## Notes

- This screen acts as a **smart router**
- Reduces confusion about which session to log
- Supports both planned and ad-hoc logging
- Mobile-optimized with large tap targets (72pt cards)

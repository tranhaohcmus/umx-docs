# Sửa Buổi học - Edit Session

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41   ← Sửa buổi học   [✕]    │
├─────────────────────────────────┤
│                                 │
│  📝 Chỉnh sửa thông tin cơ bản │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 👤 BA Bé An • 5 tuổi      │ │ Student info
│  └───────────────────────────┘ │
│                                 │
│  📅 Ngày học *                 │
│  ┌───────────────────────────┐ │
│  │ 22/10/2025            📅  │ │ Date picker
│  └───────────────────────────┘ │
│                                 │
│  🕐 Buổi *                     │
│  ┌─────────────┬─────────────┐ │
│  │ ● Sáng      │ ○ Chiều     │ │ Toggle
│  │ 8:00-11:30  │ 14:00-17:00 │ │
│  └─────────────┴─────────────┘ │
│                                 │
│  ⏰ Thời gian                  │
│  ┌──────────┬───┬──────────┐  │
│  │   8:00   │ - │  11:30   │  │ Time picker
│  └──────────┴───┴──────────┘  │
│                                 │
│  📝 Ghi chú (Tùy chọn)         │
│  ┌───────────────────────────┐ │
│  │ Buổi học về nhận diện màu │ │
│  │ sắc và vận động cơ bản... │ │
│  │                           │ │
│  └───────────────────────────┘ │
│                                 │
│  ─────────────────────────────  │
│                                 │
│  💡 Lưu ý:                     │
│  • Không thể sửa Nội dung/Mục  │
│    tiêu ở đây                  │
│  • Để chỉnh sửa Nội dung, vào  │
│    phần "Ghi nhật ký"          │
│                                 │
│  ─────────────────────────────  │
│                                 │
│  ⚠️ Buổi học đã có đánh giá    │
│  Thay đổi ngày/giờ sẽ giữ nguyên│
│  các đánh giá đã ghi.          │
│                                 │
│  ┌───────────────────────────┐ │
│  │    💾 LƯU THAY ĐỔI        │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
│  [Hủy]                          │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

## Purpose

Screen cho phép sửa thông tin **cơ bản** của buổi học đã tạo:

- Ngày học
- Buổi học (Sáng/Chiều)
- Thời gian cụ thể
- Ghi chú session

**KHÔNG SỬA ĐƯỢC:**

- Nội dung dạy học (Content)
- Mục tiêu (Goals)
- Đánh giá đã ghi (Logs)

→ Để sửa Content/Goals, dùng chức năng "Chỉnh sửa" trong screen 12-log-overview.md

## Components

### Navigation Bar

- **Back button** (←): Return to previous screen
- **Title**: "Sửa buổi học" (18pt Semibold)
- **Close button** ([✕]): Dismiss with confirmation if changed

### Student Info Card (Read-only)

- Student avatar + name
- Cannot change student for existing session

### Form Fields

#### 1. Date Field (Required)

- **Label**: "📅 Ngày học \*"
- **Input**: Date picker
- **Current value**: Session date
- **Icon**: 📅 (right side, tap to open picker)
- **Format**: DD/MM/YYYY

#### 2. Session Type (Required)

- **Label**: "🕐 Buổi \*"
- **Type**: Toggle/Segmented control (2 options)
- **Options**:
  - **Sáng**: Morning (8:00-11:30)
  - **Chiều**: Afternoon (14:00-17:00)
- **Current value**: Session's current type

#### 3. Time Range

- **Label**: "⏰ Thời gian"
- **Type**: Time range picker
- **Format**: HH:MM (24-hour)
- **Current value**: Session's current time
- **Validation**: End time must be after start time

#### 4. Notes (Optional)

- **Label**: "📝 Ghi chú (Tùy chọn)"
- **Type**: Multi-line text area
- **Current value**: Session notes
- **Max length**: 500 characters

### Info Boxes

#### Note Box (Blue)

- **Icon**: 💡
- **Message**: "Không thể sửa Nội dung/Mục tiêu ở đây. Để chỉnh sửa Nội dung, vào phần 'Ghi nhật ký'"
- **Purpose**: Clarify scope limitations

#### Warning Box (Orange) - Conditional

- **Icon**: ⚠️
- **Show when**: Session has evaluation/logs
- **Message**: "Buổi học đã có đánh giá. Thay đổi ngày/giờ sẽ giữ nguyên các đánh giá đã ghi."
- **Purpose**: Warn about preserving existing data

### Actions

- **Primary CTA**: [💾 LƯU THAY ĐỔI]
  - Enabled when any field changed
  - Disabled if no changes
- **Cancel**: [Hủy] text button
  - Show discard confirmation if changed

## Interactions

### Gestures

- **Tap date field** = Open date picker modal
- **Tap session toggle** = Switch between Sáng/Chiều (updates time defaults)
- **Tap time field** = Open time picker modal
- **Tap notes field** = Open keyboard
- **Tap LƯU THAY ĐỔI** = Validate and save
- **Tap Hủy** = Show discard confirmation if changed

### Validation

- **Date**:
  - Required
  - Cannot be more than 6 months in the past
  - Cannot be more than 1 year in the future
- **Session type**: Required
- **Time**:
  - End time must be after start time
  - Minimum duration: 30 minutes
  - Maximum duration: 8 hours
- **Notes**: Optional, max 500 chars

### Error States

- **Invalid time range**: "Giờ kết thúc phải sau giờ bắt đầu"
- **Past date warning**: "⚠️ Ngày này đã qua, bạn có chắc chắn?"
- **Conflict warning** (if applicable): "⚠️ Đã có buổi học khác vào thời gian này"

### Navigation

- **Back/Close button** → Confirmation if data changed, else return to previous
- **Cancel button** → Same as Back/Close
- **LƯU THAY ĐỔI** → Save and return to previous screen
  - Update calendar view
  - Show success toast: "✅ Đã lưu thay đổi"

### Discard Changes Confirmation

```
┌─────────────────────────────────┐
│  ⚠️ Hủy thay đổi?               │
│                                 │
│  Bạn có thay đổi chưa lưu.      │
│  Nếu thoát, mọi thay đổi sẽ bị  │
│  mất.                           │
│                                 │
│  [Ở LẠI]  [THOÁT]              │
└─────────────────────────────────┘
```

## Entry Points

### From Student Detail (Screen 02)

```
Session card menu ⋮ → "Sửa buổi học" → 04a-edit-session.md
```

**Long press or tap ⋮ on session card:**

```
┌─────────────────────┐
│ ✏️ Sửa buổi học     │
│ 🗑️ Xóa buổi học     │
│ 📋 Sao chép         │
│ ❌ Hủy              │
└─────────────────────┘
```

### From Log Overview (Screen 12)

```
Menu ⋮ (top right) → "Sửa thông tin buổi học" → 04a-edit-session.md
```

**Menu options:**

```
┌─────────────────────────┐
│ ✏️ Sửa thông tin buổi học│
│ 🗑️ Xóa buổi học         │
│ 📤 Xuất báo cáo         │
│ ❌ Hủy                  │
└─────────────────────────┘
```

## Exit Points

- **Save success** → Return to previous screen (02 or 12) with updated data
- **Cancel/Close** → Return to previous screen (no changes)

## API Integration

### Load Session Data

```javascript
GET /api/sessions/:sessionId

Response:
{
  "id": "sess_123",
  "studentId": "std_1",
  "date": "2025-10-22",
  "timeSlot": "morning",
  "startTime": "08:00",
  "endTime": "11:30",
  "notes": "Buổi học về nhận diện màu sắc...",
  "hasEvaluation": true, // Show warning box
  "contentCount": 5,
  "evaluationProgress": {
    "completed": true,
    "timestamp": "2025-10-22T11:30:00Z"
  }
}
```

### Update Session

```javascript
PATCH /api/sessions/:sessionId

Request:
{
  "date": "2025-10-23",
  "timeSlot": "afternoon",
  "startTime": "14:00",
  "endTime": "16:30",
  "notes": "Updated notes..."
}

Response:
{
  "success": true,
  "message": "Session updated successfully",
  "session": { ... }
}
```

## Business Logic

### What Changes Are Preserved

✅ **Preserved when editing:**

- All Content items
- All Goals
- All Evaluations/Logs
- Behavior records
- Teacher notes
- Media attachments

### What Can Be Changed

✅ **Editable fields:**

- Date
- Session type (Sáng/Chiều)
- Start time
- End time
- Session-level notes

### Validation Rules

1. Cannot change student (session belongs to specific student)
2. Cannot edit Content/Goals here (use screen 12 edit flow)
3. Date changes don't affect evaluation validity
4. Time changes don't affect logged data
5. Warn if changing date significantly (>7 days) with existing evaluation

## Related Screens

- **Entry from**: 02-student-detail.md, 12-log-overview.md
- **Related**: 04-manual-step1.md (similar form for creation)
- **Confirmation**: 30-confirmations.md (Discard changes)

## Notes

- **Scope limitation intentional**: Separating basic info edit from content edit reduces complexity
- **Data integrity**: Preserving evaluations when changing date/time maintains historical accuracy
- **UX clarity**: Clear notes explain what can/cannot be edited here
- **Accessibility**: All fields have VoiceOver labels, required fields announced
- **Auto-save**: Not implemented here (simple form, quick edit)
- **Conflict detection**: Optional - warn if new time conflicts with other sessions

## Design Rationale

**Why separate basic info edit from content edit?**

1. **Different contexts**: Basic info = administrative correction, Content = pedagogical changes
2. **Access control**: Teachers may need different permissions for each
3. **Complexity**: Keep forms focused and simple
4. **Validation**: Different validation rules for each type of edit
5. **Data integrity**: Prevent accidental changes to evaluated content

**Why allow date/time changes after evaluation?**

1. **Flexibility**: Teachers may need to correct mistakes (wrong date entered)
2. **Reality**: Actual session time may differ from plan
3. **Transparency**: Warnings inform about existing data
4. **Audit trail**: System logs changes for accountability

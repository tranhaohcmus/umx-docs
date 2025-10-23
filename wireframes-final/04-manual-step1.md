# Tạo thủ công - Step 1 (Basic Info)

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41   ← Tạo buổi học   [✕]    │
├─────────────────────────────────┤
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  Bước 1/3: Thông tin cơ bản    │ Stepper
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
│                                 │
│                                 │
│                                 │
│  ┌───────────────────────────┐ │
│  │    TIẾP TỤC (1/3) →       │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

## Purpose

Step 1 của quy trình tạo buổi học thủ công, thu thập thông tin cơ bản:

- Ngày học
- Buổi học (Sáng/Chiều)
- Thời gian cụ thể
- Ghi chú (tùy chọn)

## Components

### Navigation Bar

- **Back button** (←): Return to previous screen
- **Title**: "Tạo buổi học" (18pt Semibold)
- **Close button** ([✕]): Dismiss flow (with confirmation)

### Progress Stepper

- **Progress bar**: 33% filled (Step 1 of 3)
- **Step label**: "Bước 1/3: Thông tin cơ bản"

### Form Fields

#### 1. Date Field (Required)

- **Label**: "📅 Ngày học \*"
- **Input**: Date picker
- **Value**: "22/10/2025" (default: today)
- **Icon**: 📅 (right side, tap to open picker)
- **Format**: DD/MM/YYYY

#### 2. Session Type (Required)

- **Label**: "🕐 Buổi \*"
- **Type**: Toggle/Segmented control (2 options)
- **Options**:
  - **Sáng**: ● Selected state
    - Default time: 8:00-11:30
  - **Chiều**: ○ Unselected state
    - Default time: 14:00-17:00
- **Style**: Radio button style with time presets

#### 3. Time Range

- **Label**: "⏰ Thời gian"
- **Type**: Time range picker
- **Format**: HH:MM (24-hour)
- **Layout**: [Start Time] - [End Time]
- **Default**: Auto-fills based on session type
- **Validation**: End time must be after start time

#### 4. Notes (Optional)

- **Label**: "📝 Ghi chú (Tùy chọn)"
- **Type**: Multi-line text area
- **Placeholder**: "VD: Buổi học về nhận diện màu sắc..."
- **Max length**: 500 characters
- **Auto-grow**: Expands as user types (max 4 lines visible)

### Primary CTA

- **Button**: "TIẾP TỤC (1/3) →"
- **State**: Enabled when all required fields filled
- **Style**: Primary blue button, full width

### Bottom Navigation

- Visible but not primary focus
- Shows current tab context

## Interactions

### Gestures

- **Tap date field** = Open date picker modal
- **Tap session toggle** = Switch between Sáng/Chiều
- **Tap time field** = Open time picker modal
- **Tap notes field** = Open keyboard
- **Tap TIẾP TỤC** = Validate and go to Step 2

### Validation

- **Date**:
  - Required
  - Cannot be more than 6 months in the past
  - Cannot be more than 1 year in the future
  - Show warning if date is in the past
- **Session type**: Required (default: Sáng)
- **Time**:
  - Auto-fills based on session type
  - End time must be after start time
  - Minimum duration: 30 minutes
  - Maximum duration: 8 hours
- **Notes**: Optional, max 500 chars

### Error States

- **Empty required field**: Red border, error message below
- **Invalid time range**: "Giờ kết thúc phải sau giờ bắt đầu"
- **Past date warning**: "⚠️ Ngày này đã qua, bạn có chắc chắn?"

### Navigation

- **Back button** → Bottom sheet (with confirmation if data entered)
- **Close button** → Confirmation dialog: "Bạn có chắc muốn hủy? Dữ liệu sẽ không được lưu."
- **TIẾP TỤC button** → Manual Step 2 (Content)

## Validation Rules

1. **Date** is required and within valid range
2. **Session type** is required
3. **Time range** is valid (end > start, min 30min)
4. **Notes** are optional
5. All required fields must be filled to enable TIẾP TỤC button

## Auto-save Behavior

- **Draft saved**: Every 30 seconds if data entered
- **Draft restored**: If user returns to this flow
- **Draft cleared**: After successful session creation or explicit cancel

## Notes

- **Smart defaults**:
  - Date: Today
  - Session: Sáng (Morning)
  - Time: 8:00-11:30 for Sáng, 14:00-17:00 for Chiều
- **Time picker**:
  - iOS: Native UIDatePicker (wheel style)
  - Android: Material TimePicker
- **Date picker**:
  - iOS: Native calendar picker
  - Android: Material DatePicker
- **Keyboard handling**:
  - Dismiss keyboard when tap outside
  - Notes field scrolls into view when keyboard opens
- **Accessibility**:
  - VoiceOver labels for all fields
  - Required fields announced
  - Error messages announced
- **Analytics**: Track completion rate of Step 1

## Related Screens

- **Previous**: 03-create-method-sheet.md
- **Next**: 05-manual-step2.md
- **Cancel**: Back to Student Detail

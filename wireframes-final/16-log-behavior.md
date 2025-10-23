# Ghi nhật ký - Hành vi A-B-C

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41  ← Phân biệt màu   💾 [✕] │
├─────────────────────────────────┤
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  4/4: Ghi nhận Hành vi         │
│                                 │
│  ⚠️ Đã ghi nhận: 1 hành vi      │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 🏃 Tự ý rời khỏi chỗ      │ │
│  │ ──────────────────────────│ │
│  │ 🅰️ Yêu cầu làm bài khó    │ │
│  │ 🅱️ Rời chỗ, đi lại        │ │
│  │ ©️ Được nghỉ 5 phút        │ │
│  │ 📊 Mức độ: Trung bình     │ │
│  │ 🕐 10:15                  │ │
│  │                           │ │
│  │ [Xem] [Sửa] [Xóa]         │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ➕ THÊM HÀNH VI MỚI        │ │ Secondary CTA
│  └───────────────────────────┘ │
│                                 │
│  💡 Không có hành vi đặc biệt? │
│  Bạn có thể bỏ qua bước này    │
│                                 │
│                                 │
│                                 │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ✅ HOÀN TẤT & LƯU         │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
│  [← Quay lại]  [Bỏ qua bước]   │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

## Purpose

Step 4/4 - Ghi nhận hành vi theo mô hình A-B-C.

## Components

### Behavior Counter

- Shows number of behaviors logged

### Behavior Cards

Each behavior shows:

- Icon & behavior name
- 🅰️ Antecedent (Tình huống)
- 🅱️ Behavior (Hành vi)
- ©️ Consequence (Kết quả)
- Severity level
- Time occurred
- Actions: View/Edit/Delete

### Add Behavior Button

- Opens bottom sheet

### Complete Button

- Saves all logs
- Completes session

## Interactions

- **Tap behavior card** = View detail
- **Tap Sửa** = Edit behavior
- **Tap Xóa** = Delete (with confirmation)
- **Tap THÊM** = Open ABC bottom sheet
- **Tap HOÀN TẤT** = Save and complete

## Validation

- Behaviors are optional
- Can complete without behaviors
- Each behavior must have A, B, C

## Related Screens

- **Previous**: 15-log-notes.md
- **Modal**: 17-abc-sheet.md
- **Success**: 28-success-states.md

# Ghi nhật ký - Hành vi A-B-C

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41  ← Phân biệt màu   💾 [✕] │
├─────────────────────────────────┤
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  Bước 4/4: Ghi nhận Hành vi    │
│  ████████████████████████ 100% │
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
│  📚 Thư viện hành vi phổ biến: │
│  [😤 Cáu giận] [🗣️ La hét]     │
│  [🤲 Đập tay] [🏃 Rời chỗ]     │
│  [😢 Khóc] [🙅 Từ chối]        │
│  [➕ Thêm hành vi khác...]     │
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

- **[➕ THÊM HÀNH VI MỚI]**: Opens ABC bottom sheet
- **Common behavior quick tags**:
  - 😤 Cáu giận (Angry)
  - 🗣️ La hét (Screaming)
  - 🤲 Đập tay (Hand flapping)
  - 🏃 Rời chỗ (Leaving seat)
  - 😢 Khóc (Crying)
  - 🙅 Từ chối (Refusing)
  - **[➕ Thêm hành vi khác...]**: Custom behavior entry
- One-tap to select common behaviors, auto-fills behavior name
- Or create custom behavior with full A-B-C details

### Complete Button

- Saves all logs
- Completes session

## Interactions

- **Tap behavior card** = View detail
- **Tap Sửa** = Edit behavior
- **Tap Xóa** = Delete (with confirmation)
- **Tap THÊM HÀNH VI MỚI** = Open ABC bottom sheet
- **Tap common behavior tag** = Quick add with pre-filled behavior name
- **Tap [➕ Thêm hành vi khác...]** = Custom behavior entry
- **Tap HOÀN TẤT** = Save and complete logging session

## Validation

- Behaviors are optional
- Can complete without behaviors
- Each behavior must have A, B, C

## Related Screens

- **Previous**: 15-log-notes.md
- **Modal**: 17-abc-sheet.md
- **Success**: 28-success-states.md

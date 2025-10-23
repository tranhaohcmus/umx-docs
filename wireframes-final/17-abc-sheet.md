# Bottom Sheet - Thêm hành vi A-B-C

## Wireframe (3 Steps)

### Step 1: Antecedent

```
┌─────────────────────────────────┐
│         [Background Dim]        │
│   ┌─────────────────────────┐   │
│   │ ──                      │   │ Swipeable
│   │                         │   │
│   │ Ghi nhận Hành vi        │   │
│   │                         │   │
│   │ 💡 Chọn nhanh từ thư viện│  │
│   │                         │   │
│   │ 🅰️ Tình huống xảy ra    │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ 🔍 Tìm hoặc chọn... │ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ Gợi ý phổ biến:         │   │
│   │ • ⚡ Yêu cầu bài khó     │   │
│   │ • 😴 Buồn ngủ/mệt       │   │
│   │ • 🎵 Môi trường ồn      │   │
│   │ • 🍎 Không được đồ ăn   │   │
│   │ • ➕ Tình huống khác...  │   │
│   │                         │   │
│   │ [Tiếp →]                │   │
│   │                         │   │
│   └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘
```

### Step 2: Behavior

```
┌─────────────────────────────────┐
│   ┌─────────────────────────┐   │
│   │ ──                      │   │
│   │                         │   │
│   │ 🅱️ Hành vi cụ thể       │   │
│   │                         │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ 🔍 Tìm trong thư viện│ │  │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ ⭐ Thường dùng:         │   │
│   │                         │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ ⚠️ Ném đồ vật  127× │ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ 🏃 Tự ý rời chỗ 98× │ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ 📢 La hét       85× │ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ [📚 Xem tất cả 127 hành vi]│ │
│   │                         │   │
│   │ [← Quay] [Tiếp →]      │   │
│   │                         │   │
│   └─────────────────────────┘   │
└─────────────────────────────────┘
```

### Step 3: Consequence

```
┌─────────────────────────────────┐
│   ┌─────────────────────────┐   │
│   │ ──                      │   │
│   │                         │   │
│   │ ©️ Kết quả sau đó        │   │
│   │                         │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ 🔍 Tìm hoặc chọn... │ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ Phổ biến:               │   │
│   │ • ✅ Được nghỉ ngơi     │   │
│   │ • 👁️ Được chú ý         │   │
│   │ • 🎁 Được đồ chơi       │   │
│   │ • 🚫 Bị nhắc nhở        │   │
│   │ • ⏸️ Tạm dừng hoạt động │   │
│   │ • ➕ Kết quả khác...     │   │
│   │                         │   │
│   │ 📊 Mức độ hành vi       │   │
│   │ ○ ○ ● ○ ○              │   │
│   │ Nhẹ  →  Nghiêm trọng   │   │
│   │                         │   │
│   │ 🕐 Thời điểm            │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ 10:15            🕐 │ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ 📝 Mô tả chi tiết (TĐ)  │   │
│   │ ┌─────────────────────┐ │   │
│   │ │ Con ném bút xuống...│ │   │
│   │ └─────────────────────┘ │   │
│   │                         │   │
│   │ [← Quay] [💾 Lưu]      │   │
│   │ [📋 Lưu làm mẫu]       │   │
│   │                         │   │
│   └─────────────────────────┘   │
└─────────────────────────────────┘
```

## Purpose

3-step bottom sheet để ghi nhận hành vi theo mô hình A-B-C:

1. **A**ntecedent - Tình huống xảy ra
2. **B**ehavior - Hành vi cụ thể (từ thư viện)
3. **C**onsequence - Kết quả sau đó

## Components

### Step 1: Antecedent

- Search/Select input
- Suggested common antecedents
- Custom option

### Step 2: Behavior

- Search behavior library
- Frequently used behaviors (with usage count)
- Link to full dictionary
- Back/Next buttons

### Step 3: Consequence

- Search/Select input
- Common consequences
- **Severity slider** (5 levels)
- **Time picker**
- **Notes** (optional)
- **Save as template** option
- Back/Save buttons

## Interactions

### Gestures

- **Swipe down** = Close sheet
- **Swipe left/right** = Navigate steps
- **Tap suggestion** = Auto-fill
- **Tap behavior** = Select from library

### Navigation

- **Step 1 → 2**: After selecting antecedent
- **Step 2 → 3**: After selecting behavior
- **Step 3**: Complete and save

### Validation

- All 3 components required (A, B, C)
- Severity required
- Time required
- Notes optional

## Features

- **Behavior Library**: 127+ pre-defined behaviors
- **Usage tracking**: Shows frequency
- **Templates**: Save common patterns
- **Quick select**: Tap to auto-fill

## Related Screens

- **Parent**: 16-log-behavior.md
- **Library**: 18-dictionary-home.md

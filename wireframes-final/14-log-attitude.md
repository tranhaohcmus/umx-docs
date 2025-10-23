# Ghi nhật ký - Thái độ học tập

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41  ← Thái độ học tập  💾 [✕]│
├─────────────────────────────────┤
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  Bước 2/4: Thái độ Học tập     │
│  ████████████████░░░░░░ 50%   │
│                                 │
│  😊 Tâm trạng chung             │
│                                 │
│  ┌───────────────────────────┐ │
│  │   😢       😟      😐     │ │
│  │   ○        ○       ○       │ │
│  │ Rất khó  Khó    Bình       │ │
│  │  khăn   khăn   thường      │ │
│  │                            │ │
│  │   🙂       😊              │ │
│  │   ●        ○               │ │
│  │  Tốt    Rất tốt            │ │
│  └───────────────────────────┘ │
│                                 │
│  🤝 Mức độ hợp tác              │
│                                 │
│  ├────●────┼────┼────┼────┤   │ Slider
│  Rất tốt              Khó khăn │
│                                 │
│  🎯 Mức độ tập trung            │
│                                 │
│  ├────┼────●────┼────┼────┤   │ Slider
│  Rất tốt              Khó khăn │
│                                 │
│  💪 Mức độ tự lập               │
│                                 │
│  ├────●────┼────┼────┼────┤   │ Slider
│  Rất tốt              Khó khăn │
│                                 │
│  📝 Ghi chú về thái độ         │
│  ┌───────────────────────────┐ │
│  │ Con rất vui và hợp tác    │ │
│  │ trong buổi học hôm nay.   │ │
│  │ Tuy nhiên có lúc mất tập  │ │
│  │ trung khi nghe tiếng ồn...│ │
│  │                           │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │   TIẾP TỤC (2/4) →        │ │ Primary CTA
│  └───────────────────────────┘ │
│                                 │
│  [← Quay lại]     [Lưu nháp]   │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝 Ghi] [📊 Báo] [👤 Tôi]│
└─────────────────────────────────┘
```

## Purpose

Bước 2/4 - Đánh giá thái độ học tập TỔNG QUAN của học sinh trong buổi học.

## Components

### Mood Selector

- **5 emoji options with text labels**:
  - 😢 **Rất khó khăn** (Very difficult)
  - 😟 **Khó khăn** (Difficult)
  - 😐 **Bình thường** (Normal)
  - 🙂 **Tốt** (Good)
  - 😊 **Rất tốt** (Very good)
- Single selection
- Text labels below emojis for clarity
- Arranged in 2 rows for better visibility

### Sliders (3)

1. **Hợp tác** (Cooperation)
2. **Tập trung** (Focus)
3. **Tự lập** (Independence)

Each slider:

- 5 levels
- Range: Rất tốt → Khó khăn

### Notes

- Multi-line text area
- Optional
- Max 500 characters

### Actions

- Continue to Step 3 (Notes)
- Back to Step 1 (All Goals Assessment)
- Save draft

## Interactions

### Gestures

- **Tap emoji** = Select mood
- **Drag slider** = Adjust level
- **Tap text area** = Open keyboard

### Defaults

- All sliders at middle position (50%)
- No emoji selected initially
- Empty notes

## Notes

- **Overall assessment**: Attitude for entire session, not per content
- **Simplified**: Single mood + 3 sliders for whole session

## Related Screens

- **Previous**: 13-log-detail.md (All Goals)
- **Next**: 15-log-notes.md

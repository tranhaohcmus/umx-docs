# Ghi nhật ký - Thái độ học tập

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41  ← Phân biệt màu   💾 [✕] │
├─────────────────────────────────┤
│                                 │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  2/4: Thái độ Học tập          │
│                                 │
│  😊 Tâm trạng chung             │
│                                 │
│  ┌───────────────────────────┐ │
│  │   😊   😐   😕   😢   😡  │ │ Emoji selector
│  │   ●    ○    ○    ○    ○   │ │
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

Step 2/4 - Đánh giá thái độ học tập của học sinh.

## Components

### Mood Selector

- 5 emoji options
- Single selection
- Emojis: 😊 😐 😕 😢 😡

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

- Continue to Step 3
- Back to Step 1
- Save draft

## Interactions

### Gestures

- **Tap emoji** = Select mood
- **Drag slider** = Adjust level
- **Tap text area** = Open keyboard

### Defaults

- All sliders at middle position
- No emoji selected
- Empty notes

## Related Screens

- **Previous**: 13-log-detail.md
- **Next**: 15-log-notes.md

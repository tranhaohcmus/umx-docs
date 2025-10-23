# Báo cáo - So sánh Nhiều Hành vi

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41  ← So sánh           📤 ⋮ │
├─────────────────────────────────┤
│                                 │
│  📊 So sánh Hành vi             │
│  Tháng 10/2025                 │
│                                 │
│  [+ Thêm hành vi để so sánh]   │
│                                 │
│  Đang so sánh (3):              │
│  ☑️ Ném đồ vật                  │
│  ☑️ Tự ý rời chỗ                │
│  ☑️ La hét                      │
│                                 │
│  ──────────────────────────────  │
│                                 │
│  📈 Xu hướng so sánh            │
│  ┌───────────────────────────┐ │
│  │       •                   │ │
│  │      •  ■                 │ │
│  │     •    ■  ▲             │ │
│  │    •      ■  ▲            │ │
│  │   •        ■  ▲           │ │
│  │ ──────────────────────────│ │
│  │ T1   T7   T14  T21   T28  │ │
│  │                           │ │
│  │ • Ném đồ (6×)             │ │
│  │ ■ Rời chỗ (4×)            │ │
│  │ ▲ La hét (3×)             │ │
│  └───────────────────────────┘ │
│                                 │
│  📊 So sánh Tần suất            │
│  ┌───────────────────────────┐ │
│  │ Ném đồ    ██████  6 lần   │ │
│  │ Rời chỗ   ████  4 lần     │ │
│  │ La hét    ███  3 lần      │ │
│  └───────────────────────────┘ │
│                                 │
│  🎯 So sánh Chức năng           │
│  ┌───────────────────────────┐ │
│  │           Attn Esc Sens   │ │
│  │ Ném đồ     ●   ●         │ │
│  │ Rời chỗ        ●   ●     │ │
│  │ La hét     ●             │ │
│  └───────────────────────────┘ │
│                                 │
│  ⏰ So sánh Thời điểm           │
│  ┌───────────────────────────┐ │
│  │           Sáng  Chiều     │ │
│  │ Ném đồ    ████  ██       │ │
│  │ Rời chỗ   ██    ████     │ │
│  │ La hét    ███   ███      │ │
│  └───────────────────────────┘ │
│                                 │
│  📊 So sánh Mức độ              │
│  ┌───────────────────────────┐ │
│  │           Nhẹ  TB  Nặng   │ │
│  │ Ném đồ    ██  ███  █     │ │
│  │ Rời chỗ   ██  ██   ○     │ │
│  │ La hét    █   ██   █     │ │
│  └───────────────────────────┘ │
│                                 │
│  💡 Nhận xét & Gợi ý            │
│  • Ném đồ xuất hiện nhiều nhất │
│  • Rời chỗ thường ở buổi chiều │
│  • La hét có mức độ cao nhất   │
│                                 │
│  [📄 Xuất báo cáo PDF]         │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝] [📊 Báo] [👤]         │
└─────────────────────────────────┘
```

## Purpose

So sánh nhiều hành vi cùng lúc:

- Xu hướng
- Tần suất
- Chức năng
- Thời điểm
- Mức độ
- Nhận xét tự động

## Components

### Behavior Selector

- Add behavior button
- Selected behaviors (checkboxes)
- Max 5 behaviors

### Trend Comparison

- Multi-line chart
- Legend with colors

### Frequency Comparison

- Horizontal bar chart
- Count labels

### Function Comparison

- Matrix/Table view
- Checkmarks for functions

### Time Comparison

- Stacked bars
- Morning vs Afternoon

### Severity Comparison

- Grouped bars
- 3 severity levels

### Insights

- Auto-generated observations
- AI-powered suggestions

### Export

- PDF report button

## Interactions

- **Add behavior** = Open selector
- **Toggle behavior** = Update charts
- **Tap chart** = Interactive tooltips
- **Export** = Generate PDF

## Related Screens

- **Previous**: 19-analytics-overview.md
- **Detail**: 20-analytics-detail.md

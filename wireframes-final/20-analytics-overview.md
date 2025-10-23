# Báo cáo Phân tích - Overview

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41  Báo cáo & Phân tích   📤  │
├─────────────────────────────────┤
│                                 │
│  📊 Tổng quan                   │
│  ┌───────────────────────────┐ │
│  │ [Tuần này ▼]              │ │ Date range selector
│  └───────────────────────────┘ │
│                                 │
│  Dropdown options:             │
│  • Tuần này (21-27/10)         │
│  • Tháng này (1-31/10)         │
│  • 3 tháng gần đây             │
│  • 6 tháng gần đây             │
│  • Tùy chọn (chọn ngày)        │
│                                 │
│  ┌──────┬──────┬──────┬──────┐│
│  │  89% │  24  │  18  │  8   ││
│  │ Hoàn │ Buổi │ Hành │ Học  ││
│  │ thành│ học  │ vi   │ sinh ││
│  └──────┴──────┴──────┴──────┘│
│                                 │
│  📈 Xu hướng Hành vi            │
│                                 │
│  ┌───────────────────────────┐ │
│  │     •  •         •        │ │
│  │    •    •       • •       │ │
│  │   •      •     •   •      │ │
│  │  •        •   •     •     │ │
│  │ •          • •       •    │ │
│  │ ──────────────────────────│ │
│  │ T1  T7  T14  T21  T28     │ │
│  │                           │ │
│  │ ━ Tổng hành vi: 18        │ │
│  │ ━ Trung bình: 3.6/tuần    │ │
│  └───────────────────────────┘ │
│                                 │
│  🔝 Top 5 Hành vi Phổ biến     │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 1. ⚠️ Ném đồ vật       6× │ │
│  │ ████████████░░░░░░  33%   │ │
│  │ [Chi tiết →]              │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 2. 🏃 Tự ý rời chỗ     4× │ │
│  │ ████████░░░░░░░░░░  22%   │ │
│  │ [Chi tiết →]              │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 3. 📢 La hét           3× │ │
│  │ ██████░░░░░░░░░░░░  17%   │ │
│  │ [Chi tiết →]              │ │
│  └───────────────────────────┘ │
│                                 │
│  [+ 2 hành vi khác...]         │
│                                 │
│  🎯 Phân tích theo Chức năng   │
│                                 │
│  ┌─────┬─────┬─────┬─────┐     │
│  │Attn │Esc  │Sens │Tang │     │
│  │ 📢  │ 🚪  │ 🎨  │ 🎁  │     │
│  │ 8   │ 6   │ 3   │ 1   │     │
│  │44%  │33%  │17%  │6%   │     │
│  └─────┴─────┴─────┴─────┘     │
│                                 │
│  [📊 Xem báo cáo đầy đủ →]     │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝] [📊 Báo] [👤]         │
└─────────────────────────────────┘
```

## Purpose

Tổng quan báo cáo phân tích:

- Thống kê tháng
- Xu hướng hành vi
- Top behaviors
- Phân tích theo chức năng

## Components

### Month Selector

### Date Range Selector

- **[Tuần này ▼]**: Dropdown selector (prominent placement at top)
- **Preset ranges**:
  - Tuần này (Current week with dates)
  - Tháng này (Current month)
  - 3 tháng gần đây (Last 3 months)
  - 6 tháng gần đây (Last 6 months)
  - Tùy chọn (Custom date picker)
- Shows selected range in format: "21-27/10" or "Tháng 10/2025"
- All data and charts update when range changes

### Summary Stats

- Completion rate
- Total sessions
- Total behaviors
- Active students

### Trend Chart

- Line graph
- Daily/weekly view
- Average calculation

### Top Behaviors

- Ranked list
- Count & percentage
- Progress bars
- Detail links

### Function Analysis

- 4 categories grid
- Count & percentage per function

### Full Report Link

## Interactions

- **Change month** = Update all data
- **Tap behavior** = View detail
- **Tap function** = Filter by function
- **Tap "Báo cáo đầy đủ"** = Export PDF

## Related Screens

- **Detail**: 20-analytics-detail.md
- **Compare**: 21-analytics-compare.md

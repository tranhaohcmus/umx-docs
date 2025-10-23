# Báo cáo - Chi tiết Hành vi

## Wireframe

```
┌─────────────────────────────────┐
│ 9:41  ← Ném đồ vật         📤  │
├─────────────────────────────────┤
│                                 │
│  ⚠️ Ném đồ vật                  │
│  Tháng 10/2025 • 6 lần         │
│                                 │
│  📊 Xu hướng                     │
│  ┌───────────────────────────┐ │
│  │       •                   │ │
│  │      • •                  │ │
│  │     •   •   •             │ │
│  │    •     • •              │ │
│  │   •                       │ │
│  │ ──────────────────────────│ │
│  │ T1   T7   T14  T21   T28  │ │
│  │                           │ │
│  │ ↗️ Tăng 50% so tháng trước │ │
│  └───────────────────────────┘ │
│                                 │
│  🎯 Phân tích A-B-C             │
│                                 │
│  🅰️ Nguyên nhân phổ biến:       │
│  ┌───────────────────────────┐ │
│  │ ⚡ Yêu cầu bài khó    67%  │ │
│  │ ████████████░░░░░░       │ │
│  │                           │ │
│  │ 👁️ Không được chú ý   33% │ │
│  │ ██████░░░░░░░░░░░░       │ │
│  └───────────────────────────┘ │
│                                 │
│  ©️ Kết quả thường gặp:         │
│  ┌───────────────────────────┐ │
│  │ ✅ Được nghỉ ngơi     50%  │ │
│  │ ██████████░░░░░░░░       │ │
│  │                           │ │
│  │ 👁️ Được chú ý         50% │ │
│  │ ██████████░░░░░░░░       │ │
│  └───────────────────────────┘ │
│                                 │
│  📊 Phân bố Mức độ              │
│  ┌───────────────────────────┐ │
│  │ Nhẹ      ████  33%        │ │
│  │ TB       ██████  50%      │ │
│  │ Nặng     ██  17%          │ │
│  └───────────────────────────┘ │
│                                 │
│  🕐 Thời điểm hay xảy ra        │
│  ┌───────────────────────────┐ │
│  │ Sáng (8-11h)    ████  67% │ │
│  │ Chiều (14-17h)  ██   33%  │ │
│  └───────────────────────────┘ │
│                                 │
│  📝 Chi tiết các lần ghi nhận   │
│                                 │
│  ┌───────────────────────────┐ │
│  │ T3, 22/10 • 10:15 AM      │ │
│  │ 🅰️ Yêu cầu bài khó        │ │
│  │ 🅱️ Ném bút xuống          │ │
│  │ ©️ Được nghỉ 5 phút        │ │
│  │ 📊 Mức độ: Trung bình     │ │
│  │ [Xem đầy đủ →]            │ │
│  └───────────────────────────┘ │
│                                 │
│  [+ 5 lần ghi nhận khác...]    │
│                                 │
├─────────────────────────────────┤
│ [🏠] [📝] [📊 Báo] [👤]         │
└─────────────────────────────────┘
```

## Purpose

Phân tích chi tiết một hành vi:

- Xu hướng theo thời gian
- Phân tích A-B-C
- Phân bố mức độ
- Thời điểm xảy ra
- Chi tiết từng lần

## Components

### Header

- Behavior name
- Month & count
- Share button

### Trend Chart

- Line graph
- Comparison vs previous month

### ABC Analysis

- Antecedent distribution
- Consequence distribution
- Progress bars

### Severity Distribution

- Pie/Bar chart
- 3 levels

### Time Distribution

- Morning/Afternoon
- Percentage

### Incident List

- Date, time
- A-B-C summary
- Severity
- Detail link

## Interactions

- **Tap incident** = View full detail
- **Tap chart** = Interactive data
- **Share** = Export PDF report

## Related Screens

- **Previous**: 19-analytics-overview.md
- **Compare**: 21-analytics-compare.md
